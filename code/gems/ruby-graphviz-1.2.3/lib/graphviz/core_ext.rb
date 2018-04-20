class String
   def self.random(size)
      s = ""
      d = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      size.times {
         s << d[rand(d.size)]
      }
      return s
   end

   def convert_base(from, to)
      self.to_i(from).to_s(to)
   end
end

class Object
   def to_ruby
      begin
         eval self
      rescue
         self
      end
   end
end

# From : http://www.geekmade.co.uk/2008/09/ruby-tip-normalizing-hash-keys-as-symbols/
class Hash
   def symbolize_keys
      inject({}) do |options, (key, value)|
         options[(key.to_sym rescue key) || key] = value
      options
      end
   end

   # x = {
   #   :none => String,
   #   :png => "file.png",
   #   :svg => "file.svg"
   # }
   #
   # x.each_except( :key => [:none], :value => [/\.png$/] ) do |k, v|
   #   puts "#{k} -> #{v}"
   # end
   #
   # => svg -> file.svg
   def each_except( e, &b )
      key_table = (e[:key]||[]).clone.delete_if {|i| i.kind_of? Regexp }
      key_regexp = (e[:key]||[]).clone.delete_if {|i| key_table.include? i }.map {|i| i.to_s }.join("|")

      value_table = (e[:value]||[]).clone.delete_if {|i| i.kind_of? Regexp }
      value_regexp = (e[:value]||[]).clone.delete_if {|i| value_table.include? i }.map {|i| i.to_s }.join("|")

      self.each do |k, v|
         yield( k, v ) unless (key_table.size > 0 and key_table.include?(k)) or (key_regexp.size > 0 and k.to_s.match(key_regexp)) or (value_table.size > 0 and value_table.include?(v)) or (value_regexp.size > 0 and v.to_s.match(value_regexp))
      end
   end

   unless self.method_defined? :key
      # Add Hash#key to Ruby < 1.9
      def key(v)
         index(v)
      end
   end
end
