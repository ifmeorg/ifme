# Copyright Cloudinary
require 'digest/sha1'
require 'zlib'
require 'uri'
require 'aws_cf_signer'
require 'json'
require 'cgi'
require 'cloudinary/auth_token'

class Cloudinary::Utils
  # @deprecated Use Cloudinary::SHARED_CDN
  SHARED_CDN = Cloudinary::SHARED_CDN
  DEFAULT_RESPONSIVE_WIDTH_TRANSFORMATION = {:width => :auto, :crop => :limit}
  CONDITIONAL_OPERATORS = {
    "=" => 'eq',
    "!=" => 'ne',
    "<" => 'lt',
    ">" => 'gt',
    "<=" => 'lte',
    ">=" => 'gte',
    "&&" => 'and',
    "||" => 'or',
    "*" => 'mul',
    "/" => 'div',
    "+" => 'add',
    "-" => 'sub'
  }

  PREDEFINED_VARS = {
    "aspect_ratio"         => "ar",
    "current_page"         => "cp",
    "face_count"           => "fc",
    "height"               => "h",
    "initial_aspect_ratio" => "iar",
    "initial_height"       => "ih",
    "initial_width"        => "iw",
    "page_count"           => "pc",
    "page_x"               => "px",
    "page_y"               => "py",
    "tags"                 => "tags",
    "width"                => "w"
  }
  # Warning: options are being destructively updated!
  def self.generate_transformation_string(options={}, allow_implicit_crop_mode = false)
    # allow_implicit_crop_mode was added to support height and width parameters without specifying a crop mode.
    # This only apply to this (cloudinary_gem) SDK

    if options.is_a?(Array)
      return options.map{|base_transformation| generate_transformation_string(base_transformation.clone, allow_implicit_crop_mode)}.join("/")
    end

    symbolize_keys!(options)

    responsive_width = config_option_consume(options, :responsive_width)
    size = options.delete(:size)
    options[:width], options[:height] = size.split("x") if size
    width = options[:width]
    width = width.to_s if width.is_a?(Symbol)
    height = options[:height]
    has_layer = options[:overlay].present? || options[:underlay].present?

    crop = options.delete(:crop)
    angle = build_array(options.delete(:angle)).join(".")

    no_html_sizes = has_layer || angle.present? || crop.to_s == "fit" || crop.to_s == "limit" || crop.to_s == "lfill"
    options.delete(:width) if width && (width.to_f < 1 || no_html_sizes || width.to_s.start_with?("auto") || responsive_width)
    options.delete(:height) if height && (height.to_f < 1 || no_html_sizes || responsive_width)

    width=height=nil if crop.nil? && !has_layer && !width.to_s.start_with?("auto") && !allow_implicit_crop_mode

    background = options.delete(:background)
    background = background.sub(/^#/, 'rgb:') if background

    color = options.delete(:color)
    color = color.sub(/^#/, 'rgb:') if color

    base_transformations = build_array(options.delete(:transformation))
    if base_transformations.any?{|base_transformation| base_transformation.is_a?(Hash)}
      base_transformations = base_transformations.map do
        |base_transformation|
        base_transformation.is_a?(Hash) ? generate_transformation_string(base_transformation.clone, allow_implicit_crop_mode) : generate_transformation_string({:transformation=>base_transformation}, allow_implicit_crop_mode)
      end
    else
      named_transformation = base_transformations.join(".")
      base_transformations = []
    end

    effect = options.delete(:effect)
    effect = Array(effect).flatten.join(":") if effect.is_a?(Array) || effect.is_a?(Hash)

    border = options.delete(:border)
    if border.is_a?(Hash)
      border = "#{border[:width] || 2}px_solid_#{(border[:color] || "black").sub(/^#/, 'rgb:')}"
    elsif border.to_s =~ /^\d+$/ # fallback to html border attribute
      options[:border] = border
      border = nil
    end
    flags = build_array(options.delete(:flags)).join(".")
    dpr = config_option_consume(options, :dpr)

    if options.include? :offset
      options[:start_offset], options[:end_offset] = split_range options.delete(:offset)
    end

    overlay = process_layer(options.delete(:overlay))
    underlay = process_layer(options.delete(:underlay))
    ifValue = process_if(options.delete(:if))

    params = {
      :a   => normalize_expression(angle),
      :ar => normalize_expression(options.delete(:aspect_ratio)),
      :b   => background,
      :bo  => border,
      :c   => crop,
      :co  => color,
      :dpr => normalize_expression(dpr),
      :e   => normalize_expression(effect),
      :fl  => flags,
      :h   => normalize_expression(height),
      :l  => overlay,
      :o => normalize_expression(options.delete(:opacity)),
      :q => normalize_expression(options.delete(:quality)),
      :r => normalize_expression(options.delete(:radius)),
      :t   => named_transformation,
      :u  => underlay,
      :w   => normalize_expression(width),
      :x => normalize_expression(options.delete(:x)),
      :y => normalize_expression(options.delete(:y)),
      :z => normalize_expression(options.delete(:zoom))
    }
    {
      :ac => :audio_codec,
      :af => :audio_frequency,
      :br => :bit_rate,
      :cs => :color_space,
      :d  => :default_image,
      :dl => :delay,
      :dn => :density,
      :du => :duration,
      :eo => :end_offset,
      :f  => :fetch_format,
      :g  => :gravity,
      :ki => :keyframe_interval,
      :p  => :prefix,
      :pg => :page,
      :so => :start_offset,
      :sp => :streaming_profile,
      :vc => :video_codec,
      :vs => :video_sampling
    }.each do
      |param, option|
      params[param] = options.delete(option)
    end

    params[:vc] = process_video_params params[:vc] if params[:vc].present?
    [:so, :eo, :du].each do |range_value|
      params[range_value] = norm_range_value params[range_value] if params[range_value].present?
    end

    variables = options.delete(:variables)
    var_params = []
    options.each_pair do |key, value|
      if key =~ /^\$/
        var_params.push "#{key}_#{normalize_expression(value.to_s)}"
      end
    end
    var_params.sort!
    unless variables.nil? || variables.empty?
      for name, value in variables
        var_params.push "#{name}_#{normalize_expression(value.to_s)}"
      end
    end
    variables = var_params.join(',')

    raw_transformation = options.delete(:raw_transformation)
    transformation = params.reject{|_k,v| v.blank?}.map{|k,v| "#{k}_#{v}"}.sort
    transformation = transformation.join(",")
    transformation = [ifValue, variables, transformation, raw_transformation].reject(&:blank?).join(",")

    transformations = base_transformations << transformation
    if responsive_width
      responsive_width_transformation = Cloudinary.config.responsive_width_transformation || DEFAULT_RESPONSIVE_WIDTH_TRANSFORMATION
      transformations << generate_transformation_string(responsive_width_transformation.clone, allow_implicit_crop_mode)
    end

    if width.to_s.start_with?( "auto") || responsive_width
      options[:responsive] = true
    end
    if dpr.to_s == "auto"
      options[:hidpi] = true
    end

    transformations.reject(&:blank?).join("/")
  end

  # Parse "if" parameter
  # Translates the condition if provided.
  # @return [string] "if_" + ifValue
  # @private
  def self.process_if(ifValue)
    if ifValue
      ifValue = normalize_expression(ifValue)

      ifValue = "if_" + ifValue
    end
  end

  EXP_REGEXP = Regexp.new(PREDEFINED_VARS.keys.join("|")+'|('+CONDITIONAL_OPERATORS.keys.reverse.map { |k| Regexp.escape(k) }.join('|')+')(?=[ _])')
  EXP_REPLACEMENT = PREDEFINED_VARS.merge(CONDITIONAL_OPERATORS)

  def self.normalize_expression(expression)
    if expression =~ /^!.+!$/ # quoted string
      expression
    else
      expression.to_s.gsub(EXP_REGEXP,EXP_REPLACEMENT).gsub(/[ _]+/, "_")
    end
  end

  # Parse layer options
  # @return [string] layer transformation string
  # @private
  def self.process_layer(layer)
     if layer.is_a? Hash
       layer = symbolize_keys layer
       public_id     = layer[:public_id]
       format        = layer[:format]
       resource_type = layer[:resource_type] || "image"
       type          = layer[:type] || "upload"
       text          = layer[:text]
       text_style    = nil
       components    = []

       unless public_id.blank?
         public_id = public_id.gsub("/", ":")
         public_id = "#{public_id}.#{format}" unless format.nil?
       end

       if text.blank? && resource_type != "text"
         if public_id.blank?
           raise(CloudinaryException, "Must supply public_id for resource_type layer_parameter")
         end
         if resource_type == "subtitles"
           text_style = text_style(layer)
         end

       else
         resource_type = "text"
         type          = nil
         # // type is ignored for text layers
         text_style    = text_style(layer)
         unless text.blank?
           unless public_id.blank? ^ text_style.blank?
             raise(CloudinaryException, "Must supply either style parameters or a public_id when providing text parameter in a text overlay/underlay")
           end

           result = ""
           # Don't encode interpolation expressions e.g. $(variable)
           while(/\$\([a-zA-Z]\w+\)/.match text) do
             match = Regexp.last_match
             result += smart_escape smart_escape(match.pre_match, %r"([,/])") # append encoded pre-match
             result += match.to_s # append match
             text = match.post_match
           end
           text = result + smart_escape( smart_escape(text, %r"([,/])"))
         end
       end
       components.push(resource_type) if resource_type != "image"
       components.push(type) if type != "upload"
       components.push(text_style)
       components.push(public_id)
       components.push(text)
       layer = components.reject(&:blank?).join(":")
     end
     layer
  end
  private_class_method :process_layer

  LAYER_KEYWORD_PARAMS =[
    [:font_weight     ,"normal"],
    [:font_style      ,"normal"],
    [:text_decoration ,"none"],
    [:text_align      ,nil],
    [:stroke          ,"none"],
  ]

  def self.text_style(layer)
    font_family = layer[:font_family]
    font_size   = layer[:font_size]
    keywords    = []
    LAYER_KEYWORD_PARAMS.each do |attr, default_value|
      attr_value = layer[attr] || default_value
      keywords.push(attr_value) unless attr_value == default_value
    end
    letter_spacing = layer[:letter_spacing]
    keywords.push("letter_spacing_#{letter_spacing}") unless letter_spacing.blank?
    line_spacing = layer[:line_spacing]
    keywords.push("line_spacing_#{line_spacing}") unless line_spacing.blank?
    if !font_size.blank? || !font_family.blank? || !keywords.empty?
      raise(CloudinaryException, "Must supply font_family for text in overlay/underlay") if font_family.blank?
      raise(CloudinaryException, "Must supply font_size for text in overlay/underlay") if font_size.blank?
      keywords.unshift(font_size)
      keywords.unshift(font_family)
      keywords.reject(&:blank?).join("_")
    end
  end

  def self.api_string_to_sign(params_to_sign)
    params_to_sign.map{|k,v| [k.to_s, v.is_a?(Array) ? v.join(",") : v]}.reject{|k,v| v.nil? || v == ""}.sort_by(&:first).map{|k,v| "#{k}=#{v}"}.join("&")
  end

  def self.api_sign_request(params_to_sign, api_secret)
    to_sign = api_string_to_sign(params_to_sign)
    Digest::SHA1.hexdigest("#{to_sign}#{api_secret}")
  end

  def self.generate_responsive_breakpoints_string(breakpoints)
    return nil if breakpoints.nil?
    breakpoints = build_array(breakpoints)

    breakpoints.map do |breakpoint_settings|
      unless breakpoint_settings.nil?
        breakpoint_settings = breakpoint_settings.clone
        transformation =  breakpoint_settings.delete(:transformation) || breakpoint_settings.delete("transformation")
        format =  breakpoint_settings.delete(:format) || breakpoint_settings.delete("format")
        if transformation
          transformation = Cloudinary::Utils.generate_transformation_string(transformation.clone, true)
        end
        breakpoint_settings[:transformation] = [transformation, format].compact.join("/")
      end
      breakpoint_settings
    end.to_json
  end

  # Warning: options are being destructively updated!
  def self.unsigned_download_url(source, options = {})

    type = options.delete(:type)

    options[:fetch_format] ||= options.delete(:format) if type.to_s == "fetch"
    transformation = self.generate_transformation_string(options)

    resource_type = options.delete(:resource_type)
    version = options.delete(:version)
    format = options.delete(:format)
    cloud_name = config_option_consume(options, :cloud_name) || raise(CloudinaryException, "Must supply cloud_name in tag or in configuration")

    secure = options.delete(:secure)
    ssl_detected = options.delete(:ssl_detected)
    secure = ssl_detected || Cloudinary.config.secure if secure.nil?
    private_cdn = config_option_consume(options, :private_cdn)
    secure_distribution = config_option_consume(options, :secure_distribution)
    cname = config_option_consume(options, :cname)
    shorten = config_option_consume(options, :shorten)
    force_remote = options.delete(:force_remote)
    cdn_subdomain = config_option_consume(options, :cdn_subdomain)
    secure_cdn_subdomain = config_option_consume(options, :secure_cdn_subdomain)
    sign_url = config_option_consume(options, :sign_url)
    secret = config_option_consume(options, :api_secret)
    sign_version = config_option_consume(options, :sign_version) # Deprecated behavior
    url_suffix = options.delete(:url_suffix)
    use_root_path = config_option_consume(options, :use_root_path)
    auth_token = config_option_consume(options, :auth_token)
    unless auth_token == false
      auth_token = Cloudinary::AuthToken.merge_auth_token(Cloudinary.config.auth_token, auth_token)
    end

    original_source = source
    return original_source if source.blank?
    if defined?(CarrierWave::Uploader::Base) && source.is_a?(CarrierWave::Uploader::Base)
      resource_type ||= source.resource_type
      type ||= source.storage_type
      source = format.blank? ? source.filename : source.full_public_id
    end
    type = type.to_s unless type.nil?
    resource_type ||= "image"
    source = source.to_s
    if !force_remote
      static_support = Cloudinary.config.static_file_support || Cloudinary.config.static_image_support
      return original_source if !static_support && type == "asset"
      return original_source if (type.nil? || type == "asset") && source.match(%r(^https?:/)i)
      return original_source if source.match(%r(^/(?!images/).*)) # starts with / but not /images/

      source = source.sub(%r(^/images/), '') # remove /images/ prefix  - backwards compatibility
      if type == "asset"
        source, resource_type = Cloudinary::Static.public_id_and_resource_type_from_path(source)
        return original_source unless source # asset not found in Static
        source += File.extname(original_source) unless format
      end
    end

    resource_type, type = finalize_resource_type(resource_type, type, url_suffix, use_root_path, shorten)
    source, source_to_sign = finalize_source(source, format, url_suffix)

    version ||= 1 if source_to_sign.include?("/") and !source_to_sign.match(/^v[0-9]+/) and !source_to_sign.match(/^https?:\//)
    version &&= "v#{version}"

    transformation = transformation.gsub(%r(([^:])//), '\1/')
    if sign_url && ( !auth_token || auth_token.empty?)
      to_sign = [transformation, sign_version && version, source_to_sign].reject(&:blank?).join("/")
      to_sign = fully_unescape(to_sign)
      signature = 's--' + Base64.urlsafe_encode64(Digest::SHA1.digest(to_sign + secret))[0,8] + '--'
    end

    prefix = unsigned_download_url_prefix(source, cloud_name, private_cdn, cdn_subdomain, secure_cdn_subdomain, cname, secure, secure_distribution)
    source = [prefix, resource_type, type, signature, transformation, version, source].reject(&:blank?).join("/")
    if sign_url && auth_token && !auth_token.empty?
      auth_token[:url] = URI.parse(source).path
      token = Cloudinary::AuthToken.generate auth_token
      source += "?#{token}"
    end

    source
  end

  def self.finalize_source(source, format, url_suffix)
    source = source.gsub(%r(([^:])//), '\1/')
    if source.match(%r(^https?:/)i)
      source = smart_escape(source)
      source_to_sign = source
    else
      source = smart_escape(URI.decode(source))
      source_to_sign = source
      unless url_suffix.blank?
        raise(CloudinaryException, "url_suffix should not include . or /") if url_suffix.match(%r([\./]))
        source = "#{source}/#{url_suffix}"
      end
      if !format.blank?
        source = "#{source}.#{format}"
        source_to_sign = "#{source_to_sign}.#{format}"
      end
    end
    [source, source_to_sign]
  end

  def self.finalize_resource_type(resource_type, type, url_suffix, use_root_path, shorten)
    type ||= :upload
    if !url_suffix.blank?
      case
      when resource_type.to_s == "image" && type.to_s == "upload"
        resource_type = "images"
        type = nil
      when resource_type.to_s == "image" && type.to_s == "private"
        resource_type = "private_images"
        type = nil
      when resource_type.to_s == "image" && type.to_s == "authenticated"
        resource_type = "authenticated_images"
        type = nil
      when resource_type.to_s == "raw" && type.to_s == "upload"
        resource_type = "files"
        type = nil
      when resource_type.to_s == "video" && type.to_s == "upload"
        resource_type = "videos"
        type = nil
      else
        raise(CloudinaryException, "URL Suffix only supported for image/upload, image/private, image/authenticated, video/upload and raw/upload")
      end
    end
    if use_root_path
      if (resource_type.to_s == "image" && type.to_s == "upload") || (resource_type.to_s == "images" && type.blank?)
        resource_type = nil
        type = nil
      else
        raise(CloudinaryException, "Root path only supported for image/upload")
      end
    end
    if shorten && resource_type.to_s == "image" && type.to_s == "upload"
      resource_type = "iu"
      type = nil
    end
    [resource_type, type]
  end

  # Creates the URL prefix for the cloudinary resource URL
  #
  # cdn_subdomain and secure_cdn_subdomain
  # 1. Customers in shared distribution (e.g. res.cloudinary.com)
  #
  #    if cdn_domain is true uses res-[1-5 ].cloudinary.com for both http and https. Setting secure_cdn_subdomain to false disables this for https.
  # 2. Customers with private cdn
  #
  #    if cdn_domain is true uses cloudname-res-[1-5 ].cloudinary.com for http
  #
  #    if secure_cdn_domain is true uses cloudname-res-[1-5 ].cloudinary.com for https (please contact support if you require this)
  # 3. Customers with cname
  #
  #    if cdn_domain is true uses a\[1-5\]\.cname for http. For https, uses the same naming scheme as 1 for shared distribution and as 2 for private distribution.
  # @private
  def self.unsigned_download_url_prefix(source, cloud_name, private_cdn, cdn_subdomain, secure_cdn_subdomain, cname, secure, secure_distribution)
    return "/res#{cloud_name}" if cloud_name.start_with?("/") # For development

    shared_domain = !private_cdn

    if secure
      if secure_distribution.nil? || secure_distribution == Cloudinary::OLD_AKAMAI_SHARED_CDN
        secure_distribution = private_cdn ? "#{cloud_name}-res.cloudinary.com" : Cloudinary::SHARED_CDN
      end
      shared_domain ||= secure_distribution == Cloudinary::SHARED_CDN
      secure_cdn_subdomain = cdn_subdomain if secure_cdn_subdomain.nil? && shared_domain

      if secure_cdn_subdomain
        secure_distribution = secure_distribution.gsub('res.cloudinary.com', "res-#{(Zlib::crc32(source) % 5) + 1}.cloudinary.com")
      end

      prefix = "https://#{secure_distribution}"
    elsif cname
      subdomain = cdn_subdomain ? "a#{(Zlib::crc32(source) % 5) + 1}." : ""
      prefix = "http://#{subdomain}#{cname}"
    else
      host = [private_cdn ? "#{cloud_name}-" : "", "res", cdn_subdomain ? "-#{(Zlib::crc32(source) % 5) + 1}" : "", ".cloudinary.com"].join
      prefix = "http://#{host}"
    end
    prefix += "/#{cloud_name}" if shared_domain

    prefix
  end

  def self.cloudinary_api_url(action = 'upload', options = {})
    cloudinary = options[:upload_prefix] || Cloudinary.config.upload_prefix || "https://api.cloudinary.com"
    cloud_name = options[:cloud_name] || Cloudinary.config.cloud_name || raise(CloudinaryException, "Must supply cloud_name")
    resource_type = options[:resource_type] || "image"
    return [cloudinary, "v1_1", cloud_name, resource_type, action].join("/")
  end

  def self.sign_request(params, options={})
    api_key = options[:api_key] || Cloudinary.config.api_key || raise(CloudinaryException, "Must supply api_key")
    api_secret = options[:api_secret] || Cloudinary.config.api_secret || raise(CloudinaryException, "Must supply api_secret")
    params = params.reject{|k, v| self.safe_blank?(v)}
    params[:signature] = Cloudinary::Utils.api_sign_request(params, api_secret)
    params[:api_key] = api_key
    params
  end

  def self.private_download_url(public_id, format, options = {})
    cloudinary_params = sign_request({
        :timestamp=>Time.now.to_i,
        :public_id=>public_id,
        :format=>format,
        :type=>options[:type],
        :attachment=>options[:attachment],
        :expires_at=>options[:expires_at] && options[:expires_at].to_i
      }, options)

    return Cloudinary::Utils.cloudinary_api_url("download", options) + "?" + hash_query_params(cloudinary_params)
  end

  # Utility method that uses the deprecated ZIP download API.
  # @deprecated Replaced by {download_zip_url} that uses the more advanced and robust archive generation and download API
  def self.zip_download_url(tag, options = {})
    warn "zip_download_url is deprecated. Please use download_zip_url instead."
    cloudinary_params = sign_request({:timestamp=>Time.now.to_i, :tag=>tag, :transformation=>generate_transformation_string(options)}, options)
    return Cloudinary::Utils.cloudinary_api_url("download_tag.zip", options) + "?" + hash_query_params(cloudinary_params)
  end

  # Returns a URL that when invokes creates an archive and returns it.
  # @param options [Hash]
  # @option options [String|Symbol] :resource_type  The resource type of files to include in the archive. Must be one of :image | :video | :raw
  # @option options [String|Symbol] :type (:upload) The specific file type of resources: :upload|:private|:authenticated
  # @option options [String|Symbol|Array] :tags (nil) list of tags to include in the archive
  # @option options [String|Array<String>] :public_ids (nil) list of public_ids to include in the archive
  # @option options [String|Array<String>] :prefixes (nil) Optional list of prefixes of public IDs (e.g., folders).
  # @option options [String|Array<String>] :transformations Optional list of transformations.
  #   The derived images of the given transformations are included in the archive. Using the string representation of
  #   multiple chained transformations as we use for the 'eager' upload parameter.
  # @option options [String|Symbol] :mode (:create) return the generated archive file or to store it as a raw resource and
  #   return a JSON with URLs for accessing the archive. Possible values: :download, :create
  # @option options [String|Symbol] :target_format (:zip)
  # @option options [String] :target_public_id Optional public ID of the generated raw resource.
  #   Relevant only for the create mode. If not specified, random public ID is generated.
  # @option options [boolean] :flatten_folders (false) If true, flatten public IDs with folders to be in the root of the archive.
  #   Add numeric counter to the file name in case of a name conflict.
  # @option options [boolean] :flatten_transformations (false) If true, and multiple transformations are given,
  #   flatten the folder structure of derived images and store the transformation details on the file name instead.
  # @option options [boolean] :use_original_filename Use the original file name of included images (if available) instead of the public ID.
  # @option options [boolean] :async (false) If true, return immediately and perform the archive creation in the background.
  #   Relevant only for the create mode.
  # @option options [String] :notification_url Optional URL to send an HTTP post request (webhook) when the archive creation is completed.
  # @option options [String|Array<String] :target_tags Optional array. Allows assigning one or more tag to the generated archive file (for later housekeeping via the admin API).
  # @option options [String] :keep_derived (false) keep the derived images used for generating the archive
  # @return [String] archive url
  def self.download_archive_url(options = {})
    cloudinary_params = sign_request(Cloudinary::Utils.archive_params(options.merge(:mode => "download")), options)
    return Cloudinary::Utils.cloudinary_api_url("generate_archive", options) + "?" + hash_query_params(cloudinary_params)
  end


  # Returns a URL that when invokes creates an zip archive and returns it.
  # @see download_archive_url
  def self.download_zip_url(options = {})
    download_archive_url(options.merge(:target_format => "zip"))
  end

  def self.signed_download_url(public_id, options = {})
    aws_private_key_path = options[:aws_private_key_path] || Cloudinary.config.aws_private_key_path
    if aws_private_key_path
      aws_key_pair_id = options[:aws_key_pair_id] || Cloudinary.config.aws_key_pair_id || raise(CloudinaryException, "Must supply aws_key_pair_id")
      authenticated_distribution = options[:authenticated_distribution] || Cloudinary.config.authenticated_distribution || raise(CloudinaryException, "Must supply authenticated_distribution")
      @signers ||= Hash.new{|h,k| path, id = k; h[k] = AwsCfSigner.new(path, id)}
      signer = @signers[[aws_private_key_path, aws_key_pair_id]]
      url = Cloudinary::Utils.unsigned_download_url(public_id, {:type=>:authenticated}.merge(options).merge(:secure=>true, :secure_distribution=>authenticated_distribution, :private_cdn=>true))
      expires_at = options[:expires_at] || (Time.now+3600)
      return signer.sign(url, :ending => expires_at)
    else
      return Cloudinary::Utils.unsigned_download_url( public_id, options)
    end

  end

  def self.cloudinary_url(public_id, options = {})
    if options[:type].to_s == 'authenticated' && !options[:sign_url]
      result = signed_download_url(public_id, options)
    else
      result = unsigned_download_url(public_id, options)
    end
    return result
  end

  def self.asset_file_name(path)
    data = Cloudinary.app_root.join(path).read(:mode=>"rb")
    ext = path.extname
    md5 = Digest::MD5.hexdigest(data)
    public_id = "#{path.basename(ext)}-#{md5}"
    "#{public_id}#{ext}"
  end

  # Based on CGI::unescape. In addition does not escape / :
  def self.smart_escape(string, unsafe = /([^a-zA-Z0-9_.\-\/:]+)/)
    string.gsub(unsafe) do
      '%' + $1.unpack('H2' * $1.bytesize).join('%').upcase
    end
  end

  def self.random_public_id
    sr = defined?(ActiveSupport::SecureRandom) ? ActiveSupport::SecureRandom : SecureRandom
    sr.base64(20).downcase.gsub(/[^a-z0-9]/, "").sub(/^[0-9]+/, '')[0,20]
  end

  def self.signed_preloaded_image(result)
    "#{result["resource_type"]}/#{result["type"] || "upload"}/v#{result["version"]}/#{[result["public_id"], result["format"]].reject(&:blank?).join(".")}##{result["signature"]}"
  end

  @@json_decode = false
  def self.json_decode(str)
    if !@@json_decode
      @@json_decode = true
      begin
        require 'json'
      rescue LoadError
        begin
          require 'active_support/json'
        rescue LoadError
          raise LoadError, "Please add the json gem or active_support to your Gemfile"
        end
      end
    end
    defined?(JSON) ? JSON.parse(str) : ActiveSupport::JSON.decode(str)
  end

  def self.build_array(array)
    case array
      when Array then array
      when nil then []
      else [array]
    end
  end

  # encodes a hash into pipe-delimited key-value pairs string
  # @hash [Hash] key-value hash to be encoded
  # @return [String] a joined string of all keys and values separated by a pipe character
  # @private
  def self.encode_hash(hash)
    case hash
      when Hash then hash.map{|k,v| "#{k}=#{v}"}.join("|")
      when nil then ""
      else hash
    end
  end

  # Same like encode_hash, with additional escaping of | and = characters
  # @hash [Hash] key-value hash to be encoded
  # @return [String] a joined string of all keys and values properly escaped and separated by a pipe character
  # @private
  def self.encode_context(hash)
    case hash
      when Hash then hash.map{|k,v| "#{k}=#{v.to_s.gsub(/([=|])/, '\\\\\1')}"}.join("|")
      when nil then ""
      else hash
    end
  end

  def self.encode_double_array(array)
    array = build_array(array)
    if array.length > 0 && array[0].is_a?(Array)
      return array.map{|a| build_array(a).join(",")}.join("|")
    else
      return array.join(",")
    end
  end

  IMAGE_FORMATS = %w(ai bmp bpg djvu eps eps3 flif gif hdp hpx ico j2k jp2 jpc jpe jpg miff pdf png psd svg tif tiff wdp webp zip )

  AUDIO_FORMATS = %w(aac aifc aiff flac m4a mp3 ogg wav)

  VIDEO_FORMATS = %w(3g2 3gp asf avi flv h264 m2t m2v m3u8 mka mov mp4 mpeg ogv ts webm wmv )

  def self.supported_image_format?(format)
    supported_format? format, IMAGE_FORMATS
  end

  def self.supported_format?( format, formats)
    format = format.to_s.downcase
    extension = format =~ /\./ ? format.split('.').last : format
    formats.include?(extension)
  end

  def self.resource_type_for_format(format)
    case
    when self.supported_format?(format, IMAGE_FORMATS)
      'image'
    when self.supported_format?(format, VIDEO_FORMATS)
      'video'
    when self.supported_format?(format, AUDIO_FORMATS)
      'audio'
    else
      'raw'
    end
  end

  def self.config_option_consume(options, option_name, default_value = nil)
    return options.delete(option_name) if options.include?(option_name)
    return Cloudinary.config.send(option_name) || default_value
  end

  def self.as_bool(value)
    case value
    when nil then nil
    when String then value.downcase == "true" || value == "1"
    when TrueClass then true
    when FalseClass then false
    when Fixnum then value != 0
    when Symbol then value == :true
    else
      raise "Invalid boolean value #{value} of type #{value.class}"
    end
  end

  def self.as_safe_bool(value)
    case as_bool(value)
    when nil then nil
    when TrueClass then 1
    when FalseClass then 0
    end
  end

  def self.safe_blank?(value)
    value.nil? || value == "" || value == []
  end

  def self.symbolize_keys(h)
    new_h = Hash.new
    if (h.respond_to? :keys)
      h.keys.each do |key|
        new_h[(key.to_sym rescue key)] = h[key]
      end
    end
    new_h
  end


  def self.symbolize_keys!(h)
    if (h.respond_to? :keys) && (h.respond_to? :delete)
      h.keys.each do |key|
        value = h.delete(key)
        h[(key.to_sym rescue key)] = value
      end
    end
    h
  end


  def self.deep_symbolize_keys(object)
    case object
    when Hash
      result = {}
      object.each do |key, value|
        key = key.to_sym rescue key
        result[key] = deep_symbolize_keys(value)
      end
      result
    when Array
      object.map{|e| deep_symbolize_keys(e)}
    else
      object
    end
  end

  # Returns a Hash of parameters used to create an archive
  # @param [Hash] options
  # @private
  def self.archive_params(options = {})
    options = Cloudinary::Utils.symbolize_keys options
    {
      :timestamp=>(options[:timestamp] || Time.now.to_i),
      :type=>options[:type],
      :mode => options[:mode],
      :target_format => options[:target_format],
      :target_public_id=> options[:target_public_id],
      :flatten_folders=>Cloudinary::Utils.as_safe_bool(options[:flatten_folders]),
      :flatten_transformations=>Cloudinary::Utils.as_safe_bool(options[:flatten_transformations]),
      :use_original_filename=>Cloudinary::Utils.as_safe_bool(options[:use_original_filename]),
      :async=>Cloudinary::Utils.as_safe_bool(options[:async]),
      :notification_url=>options[:notification_url],
      :target_tags=>options[:target_tags] && Cloudinary::Utils.build_array(options[:target_tags]),
      :keep_derived=>Cloudinary::Utils.as_safe_bool(options[:keep_derived]),
      :tags=>options[:tags] && Cloudinary::Utils.build_array(options[:tags]),
      :public_ids=>options[:public_ids] && Cloudinary::Utils.build_array(options[:public_ids]),
      :prefixes=>options[:prefixes] && Cloudinary::Utils.build_array(options[:prefixes]),
      :expires_at=>options[:expires_at],
      :transformations => build_eager(options[:transformations]),
      :skip_transformation_name=>Cloudinary::Utils.as_safe_bool(options[:skip_transformation_name]),
      :allow_missing=>Cloudinary::Utils.as_safe_bool(options[:allow_missing])
    }
  end

  #
  # @private
  # @param [String|Hash|Array] eager an transformation as a string or hash, with or without a format. The parameter also accepts an array of eager transformations.
  def self.build_eager(eager)
    return nil if eager.nil?
    Cloudinary::Utils.build_array(eager).map do
    |transformation, format|
      unless transformation.is_a? String
        transformation = transformation.clone
        if transformation.respond_to?(:delete)
          format = transformation.delete(:format) || format
        end
        transformation = Cloudinary::Utils.generate_transformation_string(transformation, true)
      end
      [transformation, format].compact.join("/")
    end.join("|")
  end

  def self.generate_auth_token(options)
    options = Cloudinary::AuthToken.merge_auth_token Cloudinary.config.auth_token, options
    Cloudinary::AuthToken.generate options

  end
  
  private


  # Repeatedly unescapes the source until no more unescaping is possible or 10 cycles elapsed
  # @param [String] source - a (possibly) escaped string
  # @return [String] the fully unescaped string
  # @private
  def self.fully_unescape(source)
    i = 0
    while source != CGI.unescape(source.gsub('+', '%2B')) && i <10
      source = CGI.unescape(source.gsub('+', '%2B')) # don't let unescape replace '+' with space
      i = i + 1
    end
    source
  end
  private_class_method :fully_unescape
  
  def self.hash_query_params(hash)
    if hash.respond_to?("to_query")
      hash.to_query
    else
      flat_hash_to_query_params(hash)      
    end
  end

  def self.flat_hash_to_query_params(hash)
    hash.collect do |key, value|      
      if value.is_a?(Array)
        value.map{|v| "#{CGI.escape(key.to_s)}[]=#{CGI.escape(v.to_s)}"}.join("&")
      else  
        "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
      end        
    end.compact.sort!.join('&')
  end  

  def self.number_pattern
    "([0-9]*)\\.([0-9]+)|([0-9]+)"
  end
  private_class_method :number_pattern

  def self.offset_any_pattern
    "(#{number_pattern})([%pP])?"
  end
  private_class_method :offset_any_pattern

  def self.offset_any_pattern_re
    /((([0-9]*)\.([0-9]+)|([0-9]+))([%pP])?)\.\.((([0-9]*)\.([0-9]+)|([0-9]+))([%pP])?)/
  end
  private_class_method :offset_any_pattern_re

  # Split a range into the start and end values
  def self.split_range(range) # :nodoc:
    case range
    when Range
      [range.first, range.last]
    when String
      range.split ".." if offset_any_pattern_re =~ range
    when Array
      [range.first, range.last]
    else
      nil
    end
  end
  private_class_method :split_range

  # Normalize an offset value
  # @param [String] value a decimal value which may have a 'p' or '%' postfix. E.g. '35%', '0.4p'
  # @return [Object|String] a normalized String of the input value if possible otherwise the value itself
  # @private
  def self.norm_range_value(value) # :nodoc:
    offset = /^#{offset_any_pattern}$/.match( value.to_s)
    if offset
      modifier   = offset[5].present? ? 'p' : ''
      value  = "#{offset[1]}#{modifier}"
    end
    value
  end
  private_class_method :norm_range_value

  # A video codec parameter can be either a String or a Hash.
  #
  # @param [Object] param <code>vc_<codec>[ : <profile> : [<level>]]</code>
  #                       or <code>{ codec: 'h264', profile: 'basic', level: '3.1' }</code>
  # @return [String] <code><codec> : <profile> : [<level>]]</code> if a Hash was provided
  #                   or the param if a String was provided.
  #                   Returns NIL if param is not a Hash or String
  # @private
  def self.process_video_params(param)
    case param
    when Hash
      video = ""
      if param.has_key? :codec
        video = param[:codec]
        if param.has_key? :profile
          video.concat ":" + param[:profile]
          if param.has_key? :level
            video.concat ":" + param[:level]
          end
        end
      end
      video
    when String
      param
    else
      nil
    end
  end
  private_class_method :process_video_params

end
