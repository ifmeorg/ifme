require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/transform_values'

module ActiveSupport
  class Duration
    # Serializes duration to string according to ISO 8601 Duration format.
    class ISO8601Serializer
      def initialize(duration, precision: nil)
        @duration = duration
        @precision = precision
      end

      # Builds and returns output string.
      def serialize
        output = 'P'
        parts, sign = normalize
        output << "#{parts[:years]}Y"   if parts.key?(:years)
        output << "#{parts[:months]}M"  if parts.key?(:months)
        output << "#{parts[:weeks]}W"   if parts.key?(:weeks)
        output << "#{parts[:days]}D"    if parts.key?(:days)
        time = ''
        time << "#{parts[:hours]}H"     if parts.key?(:hours)
        time << "#{parts[:minutes]}M"   if parts.key?(:minutes)
        if parts.key?(:seconds)
          time << "#{sprintf(@precision ? "%0.0#{@precision}f" : '%g', parts[:seconds])}S"
        end
        output << "T#{time}"  if time.present?
        "#{sign}#{output}"
      end

      private

        # Return pair of duration's parts and whole duration sign.
        # Parts are summarized (as they can become repetitive due to addition, etc).
        # Zero parts are removed as not significant.
        # If all parts are negative it will negate all of them and return minus as a sign.
        def normalize
          parts = @duration.parts.each_with_object(Hash.new(0)) do |(k,v),p|
            p[k] += v  unless v.zero?
          end
          # If all parts are negative - let's make a negative duration
          sign = ''
          if parts.values.all? { |v| v < 0 }
            sign = '-'
            parts.transform_values!(&:-@)
          end
          [parts, sign]
        end
    end
  end
end
