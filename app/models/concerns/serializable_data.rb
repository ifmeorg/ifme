module SerializableData
  extend ActiveSupport::Concern

  def self.included(base)
    base.extend ClassMethods
    base.before_save(:array_data)
  end

  module ClassMethods
    attr_reader :_variables_to_convert

    def array_data_variables(*val)
      @_variables_to_convert = val
    end
  end

  def array_data
    self.class._variables_to_convert.each do |item|
      var = send(item)

      send("#{item}=", var.collect(&:to_i)) if !var.nil? && var.is_a?(Array)
    end
  end
end
