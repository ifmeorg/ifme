class BoolException < RuntimeError
end

# bool
#
# For the bool type,
# - TRUE values are represented by "true" or "yes" (case-insensitive), true and any non-zero integer
# - FALSE values by "false", "no" or empty string (case-insensitive), false and zero.
#
# Example
#
#   graph[:center] = "true"
# or
#   graph[:center] = true
# or
#   graph[:center] = 23
class GraphViz
   class Types
      class GvBool < Common
         BOOL_TRUE = ["true", "yes"]
         BOOL_FALSE = ["false", "no", ""]

         def check(data)
            if true == data or (data.is_a?(Integer) and data != 0) or (data.is_a?(String) and !BOOL_FALSE.include?(data.downcase))
               @to_ruby = true
               return data
            end

            if false == data or (data.is_a?(Integer) and data == 0) or (data.is_a?(String) and BOOL_FALSE.include?(data.downcase))
               @to_ruby = false
               return data
            end

            raise BoolException, "Invalid bool value"
         end

         def output
            return @data.to_s.inspect.gsub( "\\\\", "\\" )
         end

         alias :to_gv :output
         alias :to_s :output

         def to_ruby
            @to_ruby
         end
      end
   end
end
