# Copyright Cloudinary
require 'rest_client'
require 'json'

class Cloudinary::Uploader

  REMOTE_URL_REGEX = %r(^ftp:|^https?:|^s3:|^data:[^;]*;base64,([a-zA-Z0-9\/+\n=]+)$)

  # @deprecated use {Cloudinary::Utils.build_eager} instead
  def self.build_eager(eager)
    Cloudinary::Utils.build_eager(eager)
  end

  # @private
  def self.build_upload_params(options)
    #symbolize keys
    options = options.clone
    options.keys.each { |key| options[key.to_sym] = options.delete(key) if key.is_a?(String) }

    params = {
      :access_mode               => options[:access_mode],
      :allowed_formats           => Cloudinary::Utils.build_array(options[:allowed_formats]).join(","),
      :async                     => Cloudinary::Utils.as_safe_bool(options[:async]),
      :auto_tagging              => options[:auto_tagging] && options[:auto_tagging].to_f,
      :background_removal        => options[:background_removal],
      :backup                    => Cloudinary::Utils.as_safe_bool(options[:backup]),
      :callback                  => options[:callback],
      :categorization            => options[:categorization],
      :colors                    => Cloudinary::Utils.as_safe_bool(options[:colors]),
      :context                   => Cloudinary::Utils.encode_context(options[:context]),
      :custom_coordinates        => Cloudinary::Utils.encode_double_array(options[:custom_coordinates]),
      :detection                 => options[:detection],
      :discard_original_filename => Cloudinary::Utils.as_safe_bool(options[:discard_original_filename]),
      :eager                     => Cloudinary::Utils.build_eager(options[:eager]),
      :eager_async               => Cloudinary::Utils.as_safe_bool(options[:eager_async]),
      :eager_notification_url    => options[:eager_notification_url],
      :exif                      => Cloudinary::Utils.as_safe_bool(options[:exif]),
      :face_coordinates          => Cloudinary::Utils.encode_double_array(options[:face_coordinates]),
      :faces                     => Cloudinary::Utils.as_safe_bool(options[:faces]),
      :folder                    => options[:folder],
      :format                    => options[:format],
      :headers                   => build_custom_headers(options[:headers]),
      :image_metadata            => Cloudinary::Utils.as_safe_bool(options[:image_metadata]),
      :invalidate                => Cloudinary::Utils.as_safe_bool(options[:invalidate]),
      :moderation                => options[:moderation],
      :notification_url          => options[:notification_url],
      :ocr                       => options[:ocr],
      :overwrite                 => Cloudinary::Utils.as_safe_bool(options[:overwrite]),
      :phash                     => Cloudinary::Utils.as_safe_bool(options[:phash]),
      :proxy                     => options[:proxy],
      :public_id                 => options[:public_id],
      :raw_convert               => options[:raw_convert],
      :responsive_breakpoints    => Cloudinary::Utils.generate_responsive_breakpoints_string(options[:responsive_breakpoints]),
      :return_delete_token       => Cloudinary::Utils.as_safe_bool(options[:return_delete_token]),
      :similarity_search         => options[:similarity_search],
      :tags                      => options[:tags] && Cloudinary::Utils.build_array(options[:tags]).join(","),
      :timestamp                 => (options[:timestamp] || Time.now.to_i),
      :transformation            => Cloudinary::Utils.generate_transformation_string(options.clone),
      :type                      => options[:type],
      :unique_filename           => Cloudinary::Utils.as_safe_bool(options[:unique_filename]),
      :upload_preset             => options[:upload_preset],
      :use_filename              => Cloudinary::Utils.as_safe_bool(options[:use_filename]),
    }
    params
  end

  def self.unsigned_upload(file, upload_preset, options={})
    upload(file, options.merge(:unsigned => true, :upload_preset => upload_preset))
  end

  def self.upload(file, options={})
    call_api("upload", options) do
      params = build_upload_params(options)
      if file.is_a?(Pathname)
        params[:file] = File.open(file, "rb")
      elsif file.respond_to?(:read) || file.match(REMOTE_URL_REGEX)
        params[:file] = file
      else
        params[:file] = File.open(file, "rb")
      end
      [params, [:file]]
    end
  end

  # Upload large files. Note that public_id should include an extension for best results.
  def self.upload_large(file, public_id_or_options={}, old_options={})
    if public_id_or_options.is_a?(Hash)
      options   = public_id_or_options
      public_id = options[:public_id]
    else
      public_id = public_id_or_options
      options   = old_options
    end
    if file.match(REMOTE_URL_REGEX)
      return upload(file, options.merge(:public_id => public_id))
    elsif file.is_a?(Pathname) || !file.respond_to?(:read)
      filename = file
      file     = File.open(file, "rb")
    else
      filename = "cloudinaryfile"
    end
    upload     = nil
    index      = 0
    chunk_size = options[:chunk_size] || 20_000_000
    until file.eof?
      buffer      = file.read(chunk_size)
      current_loc = index*chunk_size
      range       = "bytes #{current_loc}-#{current_loc+buffer.size - 1}/#{file.size}"
      upload      = upload_large_part(Cloudinary::Blob.new(buffer, :original_filename => filename), options.merge(:public_id => public_id, :content_range => range))
      public_id   = upload["public_id"]
      index       += 1
    end
    upload
  end


  # Upload large  files. Note that public_id should include an extension for best results.
  def self.upload_large_part(file, options={})
    options[:resource_type] ||= :raw
    call_api("upload", options) do
      params = build_upload_params(options)
      if file.is_a?(Pathname) || !file.respond_to?(:read)
        params[:file] = File.open(file, "rb")
      else
        params[:file] = file
      end
      [params, [:file]]
    end
  end

  def self.destroy(public_id, options={})
    call_api("destroy", options) do
      {
        :timestamp  => (options[:timestamp] || Time.now.to_i),
        :type       => options[:type],
        :public_id  => public_id,
        :invalidate => options[:invalidate],
      }
    end
  end

  def self.rename(from_public_id, to_public_id, options={})
    call_api("rename", options) do
      {
        :timestamp      => (options[:timestamp] || Time.now.to_i),
        :type           => options[:type],
        :overwrite      => Cloudinary::Utils.as_safe_bool(options[:overwrite]),
        :from_public_id => from_public_id,
        :to_public_id   => to_public_id,
        :to_type        => options[:to_type],
        :invalidate     => Cloudinary::Utils.as_safe_bool(options[:invalidate])
      }
    end
  end

  def self.exists?(public_id, options={})
    cloudinary_url = Cloudinary::Utils.cloudinary_url(public_id, options)
    begin
      code = RestClient::Request.execute(:method => :head, :url => cloudinary_url, :timeout => 5).code
      code >= 200 && code < 300
    rescue RestClient::ResourceNotFound
      return false
    end

  end

  def self.explicit(public_id, options={})
    call_api("explicit", options) do
      params             = build_upload_params(options)
      params[:public_id] = public_id
      params
    end
  end

  # Creates a new archive in the server and returns information in JSON format
  def self.create_archive(options={}, target_format = nil)
    call_api("generate_archive", options) do
      params                 = Cloudinary::Utils.archive_params(options)
      params[:target_format] = target_format if target_format
      params
    end
  end

  # Creates a new zip archive in the server and returns information in JSON format
  def self.create_zip(options={})
    create_archive(options, "zip")
  end

  TEXT_PARAMS = [:public_id, :font_family, :font_size, :font_color, :text_align, :font_weight, :font_style, :background, :opacity, :text_decoration, :line_spacing]

  def self.text(text, options={})
    call_api("text", options) do
      params = { :timestamp => Time.now.to_i, :text => text }
      TEXT_PARAMS.each { |k| params[k] = options[k] unless options[k].nil? }
      params
    end
  end

  def self.generate_sprite(tag, options={})
    version_store = options.delete(:version_store)

    result = call_api("sprite", options) do
      {
        :timestamp        => (options[:timestamp] || Time.now.to_i),
        :tag              => tag,
        :async            => options[:async],
        :notification_url => options[:notification_url],
        :transformation   => Cloudinary::Utils.generate_transformation_string(options.merge(:fetch_format => options[:format]))
      }
    end

    if version_store == :file && result && result["version"]
      if defined?(Rails) && defined?(Rails.root)
        FileUtils.mkdir_p("#{Rails.root}/tmp/cloudinary")
        File.open("#{Rails.root}/tmp/cloudinary/cloudinary_sprite_#{tag}.version", "w") { |file| file.print result["version"].to_s }
      end
    end
    return result
  end

  def self.multi(tag, options={})
    call_api("multi", options) do
      {
        :timestamp        => (options[:timestamp] || Time.now.to_i),
        :tag              => tag,
        :format           => options[:format],
        :async            => options[:async],
        :notification_url => options[:notification_url],
        :transformation   => Cloudinary::Utils.generate_transformation_string(options.clone)
      }
    end
  end

  def self.explode(public_id, options={})
    call_api("explode", options) do
      {
        :timestamp        => (options[:timestamp] || Time.now.to_i),
        :public_id        => public_id,
        :type             => options[:type],
        :format           => options[:format],
        :notification_url => options[:notification_url],
        :transformation   => Cloudinary::Utils.generate_transformation_string(options.clone)
      }
    end
  end

  # options may include 'exclusive' (boolean) which causes clearing this tag from all other resources 
  def self.add_tag(tag, public_ids = [], options = {})
    exclusive = options.delete(:exclusive)
    command   = exclusive ? "set_exclusive" : "add"
    return self.call_tags_api(tag, command, public_ids, options)
  end

  def self.remove_tag(tag, public_ids = [], options = {})
    return self.call_tags_api(tag, "remove", public_ids, options)
  end

  def self.replace_tag(tag, public_ids = [], options = {})
    return self.call_tags_api(tag, "replace", public_ids, options)
  end

  def self.remove_all_tags(public_ids = [], options = {})
    return self.call_tags_api(nil, "remove_all", public_ids, options)
  end

  private

  def self.call_tags_api(tag, command, public_ids = [], options = {})
    return call_api("tags", options) do
      {
        :timestamp  => (options[:timestamp] || Time.now.to_i),
        :tag        => tag,
        :public_ids => Cloudinary::Utils.build_array(public_ids),
        :command    => command,
        :type       => options[:type]
      }
    end
  end

  def self.add_context(context, public_ids = [], options = {})
    return self.call_context_api(context, "add", public_ids, options)
  end

  def self.remove_all_context(public_ids = [], options = {})
    return self.call_context_api(nil, "remove_all", public_ids, options)
  end

  private

  def self.call_context_api(context, command, public_ids = [], options = {})
    return call_api("context", options) do
      {
        :timestamp  => (options[:timestamp] || Time.now.to_i),
        :context    => Cloudinary::Utils.encode_hash(context),
        :public_ids => Cloudinary::Utils.build_array(public_ids),
        :command    => command,
        :type       => options[:type]
      }
    end
  end

  def self.call_api(action, options)
    options      = options.clone
    return_error = options.delete(:return_error)

    params, non_signable = yield
    non_signable         ||= []

    unless options[:unsigned]
      api_key            = options[:api_key] || Cloudinary.config.api_key || raise(CloudinaryException, "Must supply api_key")
      api_secret         = options[:api_secret] || Cloudinary.config.api_secret || raise(CloudinaryException, "Must supply api_secret")
      params[:signature] = Cloudinary::Utils.api_sign_request(params.reject { |k, v| non_signable.include?(k) }, api_secret)
      params[:api_key]   = api_key
    end
    timeout = options[:timeout] || Cloudinary.config.timeout || 60

    result = nil

    api_url                  = Cloudinary::Utils.cloudinary_api_url(action, options)
    headers                  = { "User-Agent" => Cloudinary::USER_AGENT }
    headers['Content-Range'] = options[:content_range] if options[:content_range]
    headers.merge!(options[:extra_headers]) if options[:extra_headers]
    RestClient::Request.execute(:method => :post, :url => api_url, :payload => params.reject { |k, v| v.nil? || v=="" }, :timeout => timeout, :headers => headers) do
    |response, request, tmpresult|
      raise CloudinaryException, "Server returned unexpected status code - #{response.code} - #{response.body}" unless [200, 400, 401, 403, 404, 500].include?(response.code)
      begin
        result = Cloudinary::Utils.json_decode(response.body)
      rescue => e
        # Error is parsing json
        raise CloudinaryException, "Error parsing server response (#{response.code}) - #{response.body}. Got - #{e}"
      end
      if result["error"]
        if return_error
          result["error"]["http_code"] = response.code
        else
          raise CloudinaryException, result["error"]["message"]
        end
      end
    end

    result
  end

  def self.build_custom_headers(headers)
    Array(headers).map { |*a| a.join(": ") }.join("\n")
  end
end
