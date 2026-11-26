# frozen_string_literal: true

# Resolves a model-name string (e.g. "moment", "category") into the
# matching named route helper via `send`, validating it against an
# explicit allowlist first so the call can't be driven by an arbitrary
# string.
module ResourceRouting
  COMMENTABLE_DATA_TYPES = %w[moment strategy meeting].freeze

  def resource_index_path(data_type, allowed_data_types, *args)
    validate_resource_data_type!(data_type, allowed_data_types)
    send("#{data_type.to_s.pluralize}_path", *args)
  end

  def resource_show_url(data_type, allowed_data_types, *args)
    validate_resource_data_type!(data_type, allowed_data_types)
    send("#{data_type}_url", *args)
  end

  private

  def validate_resource_data_type!(data_type, allowed_data_types)
    return if allowed_data_types.include?(data_type.to_s)

    raise ArgumentError, "unknown data_type: #{data_type}"
  end
end
