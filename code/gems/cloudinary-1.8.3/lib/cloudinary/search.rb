class Cloudinary::Search
  def initialize
    @query_hash = {
      :sort_by    => [],
      :aggregate  => [],
      :with_field   => []
    }
  end

  ## implicitly generate an instance delegate the method
  def self.method_missing(method_name, *arguments)
    instance = new
    instance.send(method_name, *arguments)
  end

  def expression(value)
    @query_hash[:expression] = value
    self
  end

  def max_results(value)
    @query_hash[:max_results] = value
    self
  end

  def next_cursor(value)
    @query_hash[:next_cursor] = value
    self
  end

  def sort_by(field_name, dir = 'desc')
    @query_hash[:sort_by].push(field_name => dir)
    self
  end

  def aggregate(value)
    @query_hash[:aggregate].push(value)
    self
  end

  def with_field(value)
    @query_hash[:with_field].push(value)
    self
  end

  def to_h
    @query_hash.select { |_, value| !value.nil? && !(value.is_a?(Array) && value.empty?) }
  end

  def execute(options = {})
    options[:content_type] = :json
    uri = 'resources/search'
    Cloudinary::Api.call_api(:post, uri, to_h, options)
  end
end
