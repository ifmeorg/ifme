require 'rest_client'
require 'json'

class Cloudinary::Api
  class Error < CloudinaryException; end
  class NotFound < Error; end
  class NotAllowed < Error; end
  class AlreadyExists < Error; end
  class RateLimited < Error; end
  class BadRequest < Error; end
  class GeneralError < Error; end
  class AuthorizationRequired < Error; end

  class Response < Hash
    attr_reader :rate_limit_reset_at, :rate_limit_remaining, :rate_limit_allowed

    def initialize(response=nil)
      if response
        # This sets the instantiated self as the response Hash
        update Cloudinary::Api.parse_json_response response

        @rate_limit_allowed   = response.headers[:x_featureratelimit_limit].to_i
        @rate_limit_reset_at  = Time.parse(response.headers[:x_featureratelimit_reset])
        @rate_limit_remaining = response.headers[:x_featureratelimit_remaining].to_i
      end
    end
  end

  def self.ping(options={})
    call_api(:get, "ping", {}, options)
  end

  def self.usage(options={})
    call_api(:get, "usage", {}, options)
  end

  def self.resource_types(options={})
    call_api(:get, "resources", {}, options)
  end

  def self.resources(options={})
    resource_type = options[:resource_type] || "image"
    type          = options[:type]
    uri           = "resources/#{resource_type}"
    uri           += "/#{type}" unless type.blank?
    call_api(:get, uri, only(options, :next_cursor, :max_results, :prefix, :tags, :context, :moderations, :direction, :start_at), options)
  end

  def self.resources_by_tag(tag, options={})
    resource_type = options[:resource_type] || "image"
    uri           = "resources/#{resource_type}/tags/#{tag}"
    call_api(:get, uri, only(options, :next_cursor, :max_results, :tags, :context, :moderations, :direction), options)
  end

  def self.resources_by_moderation(kind, status, options={})
    resource_type = options[:resource_type] || "image"
    uri           = "resources/#{resource_type}/moderations/#{kind}/#{status}"
    call_api(:get, uri, only(options, :next_cursor, :max_results, :tags, :context, :moderations, :direction), options)
  end

  def self.resources_by_context(key, value=nil, options={})
    resource_type = options[:resource_type] || "image"
    uri           = "resources/#{resource_type}/context"
    params = only(options, :next_cursor, :max_results, :tags, :context, :moderations, :direction,:key,:value)
    params[:key] = key
    params[:value] = value
    call_api(:get, uri, params, options)
  end

  def self.resources_by_ids(public_ids, options={})
    resource_type = options[:resource_type] || "image"
    type          = options[:type] || "upload"
    uri           = "resources/#{resource_type}/#{type}"
    call_api(:get, uri, only(options, :tags, :context, :moderations).merge(:public_ids => public_ids), options)
  end

  def self.resource(public_id, options={})
    resource_type = options[:resource_type] || "image"
    type          = options[:type] || "upload"
    uri           = "resources/#{resource_type}/#{type}/#{public_id}"
    call_api(:get, uri, only(options, :colors, :exif, :faces, :image_metadata, :pages, :phash, :coordinates, :max_results), options)
  end

  def self.restore(public_ids, options={})
    resource_type = options[:resource_type] || "image"
    type          = options[:type] || "upload"
    uri           = "resources/#{resource_type}/#{type}/restore"
    call_api(:post, uri, { :public_ids => public_ids }, options)
  end

  def self.update(public_id, options={})
    resource_type  = options[:resource_type] || "image"
    type           = options[:type] || "upload"
    uri            = "resources/#{resource_type}/#{type}/#{public_id}"
    update_options = {
      :tags               => options[:tags] && Cloudinary::Utils.build_array(options[:tags]).join(","),
      :context            => Cloudinary::Utils.encode_context(options[:context]),
      :face_coordinates   => Cloudinary::Utils.encode_double_array(options[:face_coordinates]),
      :custom_coordinates => Cloudinary::Utils.encode_double_array(options[:custom_coordinates]),
      :moderation_status  => options[:moderation_status],
      :raw_convert        => options[:raw_convert],
      :ocr                => options[:ocr],
      :categorization     => options[:categorization],
      :detection          => options[:detection],
      :similarity_search  => options[:similarity_search],
      :background_removal => options[:background_removal],
      :auto_tagging       => options[:auto_tagging] && options[:auto_tagging].to_f,
      :notification_url   => options[:notification_url]
    }
    call_api(:post, uri, update_options, options)
  end

  def self.delete_resources(public_ids, options={})
    resource_type = options[:resource_type] || "image"
    type          = options[:type] || "upload"
    uri           = "resources/#{resource_type}/#{type}"
    call_api(:delete, uri, delete_resource_params(options, :public_ids => public_ids ), options)
  end

  def self.delete_resources_by_prefix(prefix, options={})
    resource_type = options[:resource_type] || "image"
    type          = options[:type] || "upload"
    uri           = "resources/#{resource_type}/#{type}"
    call_api(:delete, uri, delete_resource_params(options, :prefix => prefix), options)
  end

  def self.delete_all_resources(options={})
    resource_type = options[:resource_type] || "image"
    type          = options[:type] || "upload"
    uri           = "resources/#{resource_type}/#{type}"
    call_api(:delete, uri, delete_resource_params(options, :all => true ), options)
  end

  def self.delete_resources_by_tag(tag, options={})
    resource_type = options[:resource_type] || "image"
    uri           = "resources/#{resource_type}/tags/#{tag}"
    call_api(:delete, uri, delete_resource_params(options), options)
  end

  def self.delete_derived_resources(derived_resource_ids, options={})
    uri = "derived_resources"
    call_api(:delete, uri, { :derived_resource_ids => derived_resource_ids }, options)
  end

  # Delete derived resources identified by transformation for the provided public_ids
  # @param [String|Array] public_ids The resources the derived resources belong to
  # @param [String|Hash|Array] transformations the transformation(s) associated with the derived resources
  # @param [Hash] options
  # @option options [String] :resource_type ("image")
  # @option options [String] :type ("upload")
  def self.delete_derived_by_transformation(public_ids, transformations, options={})
    resource_type = options[:resource_type] || "image"
    type          = options[:type] || "upload"
    uri           = "resources/#{resource_type}/#{type}"
    params = {:public_ids => public_ids}.merge(only(options, :invalidate))
    params[:keep_original] = true
    params[:transformations] = Cloudinary::Utils.build_eager(transformations)
    call_api(:delete, uri, params, options)
  end

  def self.tags(options={})
    resource_type = options[:resource_type] || "image"
    uri           = "tags/#{resource_type}"
    call_api(:get, uri, only(options, :next_cursor, :max_results, :prefix), options)
  end

  def self.transformations(options={})
    call_api(:get, "transformations", only(options, :named, :next_cursor, :max_results), options)
  end

  def self.transformation(transformation, options={})
    call_api(:get, "transformations/#{transformation_string(transformation)}", only(options, :next_cursor, :max_results), options)
  end

  def self.delete_transformation(transformation, options={})
    call_api(:delete, "transformations/#{transformation_string(transformation)}", {}, options)
  end

  # updates - supports:
  #   "allowed_for_strict" boolean
  #   "unsafe_update" transformation params - updates a named transformation parameters without regenerating existing images
  def self.update_transformation(transformation, updates, options={})
    params                 = only(updates, :allowed_for_strict)
    params[:unsafe_update] = transformation_string(updates[:unsafe_update]) if updates[:unsafe_update]
    call_api(:put, "transformations/#{transformation_string(transformation)}", params, options)
  end

  def self.create_transformation(name, definition, options={})
    call_api(:post, "transformations/#{name}", { :transformation => transformation_string(definition) }, options)
  end

  # upload presets
  def self.upload_presets(options={})
    call_api(:get, "upload_presets", only(options, :next_cursor, :max_results), options)
  end

  def self.upload_preset(name, options={})
    call_api(:get, "upload_presets/#{name}", only(options, :max_results), options)
  end

  def self.delete_upload_preset(name, options={})
    call_api(:delete, "upload_presets/#{name}", {}, options)
  end

  def self.update_upload_preset(name, options={})
    params = Cloudinary::Uploader.build_upload_params(options)
    call_api(:put, "upload_presets/#{name}", params.merge(only(options, :unsigned, :disallow_public_id)), options)
  end

  def self.create_upload_preset(options={})
    params = Cloudinary::Uploader.build_upload_params(options)
    call_api(:post, "upload_presets", params.merge(only(options, :name, :unsigned, :disallow_public_id)), options)
  end

  def self.root_folders(options={})
    call_api(:get, "folders", {}, options)
  end

  def self.subfolders(of_folder_path, options={})
    call_api(:get, "folders/#{of_folder_path}", {}, options)
  end

  def self.upload_mappings(options={})
    params = only(options, :next_cursor, :max_results)
    call_api(:get, :upload_mappings, params, options)
  end

  def self.upload_mapping(name=nil, options={})
    call_api(:get, 'upload_mappings', { :folder => name }, options)
  end

  def self.delete_upload_mapping(name, options={})
    call_api(:delete, 'upload_mappings', { :folder => name }, options)
  end

  def self.update_upload_mapping(name, options={})
    params          = only(options, :template)
    params[:folder] = name
    call_api(:put, 'upload_mappings', params, options)
  end

  def self.create_upload_mapping(name, options={})
    params          = only(options, :template)
    params[:folder] = name
    call_api(:post, 'upload_mappings', params, options)
  end

  def self.create_streaming_profile(name, options={})
      params = only(options, :display_name, :representations)
      params[:representations] = params[:representations].map do |r|
        {:transformation => Cloudinary::Utils.generate_transformation_string(r[:transformation])}
      end.to_json
      params[:name] = name
      call_api(:post, 'streaming_profiles', params, options)
  end

  def self.list_streaming_profiles
    call_api(:get, 'streaming_profiles', {}, {})
  end

  def self.delete_streaming_profile(name, options={})
    call_api(:delete, "streaming_profiles/#{name}", {}, options)
  end

  def self.get_streaming_profile(name, options={})
    call_api(:get, "streaming_profiles/#{name}", {}, options)
  end

  def self.update_streaming_profile(name, options={})
    params = only(options, :display_name, :representations)
    params[:representations] = params[:representations].map do |r|
      {:transformation => Cloudinary::Utils.generate_transformation_string(r[:transformation])}
    end.to_json
    call_api(:put, "streaming_profiles/#{name}", params, options)
  end

  # Update resources access mode. Resources are selected by the prefix
  # @param [String] access_mode the access mode to set the resources to
  # @param [String] prefix The prefix by which to filter applicable resources
  # @param [Object] options    additional options
  # @option options [String] :resource_type ("image") the type of resources to modify
  # @option options [Fixnum] :max_results (nil) the maximum resources to process in a single invocation
  # @option options [String] :next_cursor (nil) provided by a previous call to the method
  def self.update_resources_access_mode_by_prefix(access_mode, prefix, options = {})

      update_resources_access_mode(access_mode, :prefix, prefix, options)
  end

  # Update resources access mode. Resources are selected by the tag
  # @param [String] access_mode the access mode to set the resources to
  # @param [String] tag the tag by which to filter applicable resources
  # @param [Object] options    additional options
  # @option options [String] :resource_type ("image") the type of resources to modify
  # @option options [Fixnum] :max_results (nil) the maximum resources to process in a single invocation
  # @option options [String] :next_cursor (nil) provided by a previous call to the method
  def self.update_resources_access_mode_by_tag(access_mode, tag, options = {})

      update_resources_access_mode(access_mode, :tag, tag, options)
  end

  # Update resources access mode. Resources are selected by the provided public_ids
  # @param [String] access_mode the access mode to set the resources to
  # @param [Array<String>] public_ids The prefix by which to filter applicable resources
  # @param [Object] options    additional options
  # @option options [String] :resource_type ("image") the type of resources to modify
  # @option options [Fixnum] :max_results (nil) the maximum resources to process in a single invocation
  # @option options [String] :next_cursor (nil) provided by a previous call to the method
  def self.update_resources_access_mode_by_ids(access_mode, public_ids, options = {})

      update_resources_access_mode(access_mode, :public_ids, public_ids, options)
  end

  protected

  def self.call_api(method, uri, params, options)
    cloudinary = options[:upload_prefix] || Cloudinary.config.upload_prefix || "https://api.cloudinary.com"
    cloud_name = options[:cloud_name] || Cloudinary.config.cloud_name || raise("Must supply cloud_name")
    api_key    = options[:api_key] || Cloudinary.config.api_key || raise("Must supply api_key")
    api_secret = options[:api_secret] || Cloudinary.config.api_secret || raise("Must supply api_secret")
    timeout    = options[:timeout] || Cloudinary.config.timeout || 60
    api_url    = [cloudinary, "v1_1", cloud_name, uri].join("/")
    # Add authentication
    api_url.sub!(%r(^(https?://)), "\\1#{api_key}:#{api_secret}@")

    headers = { "User-Agent" => Cloudinary::USER_AGENT }
    if options[:content_type]== :json
      payload = params.to_json
      headers.merge!("Content-Type"=> 'application/json', "Accept"=> 'application/json')
    else
      payload = params.reject { |k, v| v.nil? || v=="" }
    end
    RestClient::Request.execute(:method => method, :url => api_url, :payload => payload, :timeout => timeout, :headers => headers) do
    |response, request, tmpresult|
      return Response.new(response) if response.code == 200
      exception_class = case response.code
      when 400 then BadRequest
      when 401 then AuthorizationRequired
      when 403 then NotAllowed
      when 404 then NotFound
      when 409 then AlreadyExists
      when 420 then RateLimited
      when 500 then GeneralError
      else raise GeneralError.new("Server returned unexpected status code - #{response.code} - #{response.body}")
      end
      json = parse_json_response(response)
      raise exception_class.new(json["error"]["message"])
    end
  end

  def self.parse_json_response(response)
    return Cloudinary::Utils.json_decode(response.body)
  rescue => e
    # Error is parsing json
    raise GeneralError.new("Error parsing server response (#{response.code}) - #{response.body}. Got - #{e}")
  end

  def self.only(hash, *keys)
    result = {}
    keys.each do |key|
      result[key] = hash[key] if hash.include?(key)
      result[key] = hash[key.to_s] if hash.include?(key.to_s)
    end
    result
  end

  def self.delete_resource_params(options, params ={})
    params.merge(only(options, :keep_original, :next_cursor, :invalidate, :transformations))
  end

  def self.transformation_string(transformation)
    transformation.is_a?(String) ? transformation : Cloudinary::Utils.generate_transformation_string(transformation.clone)
  end

  def self.publish_resources(options = {})
    resource_type = options[:resource_type] || "image"
    params = only(options, :public_ids, :prefix, :tag, :type, :overwrite, :invalidate)
    call_api("post", "resources/#{resource_type}/publish_resources", params, options)
  end

  def self.publish_by_prefix(prefix, options = {})
    return self.publish_resources(options.merge(:prefix => prefix))
  end

  def self.publish_by_tag(tag, options = {})
    return self.publish_resources(options.merge(:tag => tag))
  end

  def self.publish_by_ids(publicIds, options = {})
    return self.publish_resources(options.merge(:public_ids => publicIds))
  end

  def self.update_resources_access_mode(access_mode, by_key, value, options = {})
    resource_type = options[:resource_type] || "image"
    type = options[:type] || "upload"
    params = only(options, :next_cursor)
    params[:access_mode] = access_mode
    params[by_key] = value
    call_api("post", "resources/#{resource_type}/#{type}/update_access_mode", params, options)
  end

end
