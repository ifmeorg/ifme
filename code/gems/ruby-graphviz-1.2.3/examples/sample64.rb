$:.unshift( "../lib" )
require 'graphviz/dsl'

digraph :G do

   node[:color => :lightblue, :style => :filled, :shape => :egg]
   edge[:color => :gray, :arrowhead => :vee]

   e "C/C++", "Java"

   java do
      n("Java") << n("Groovy")
      n("Java") << n("Clojure")
      n("Java") << n("JRuby")
      graph[:label => "Java", :color => :blue]
   end

   e "C/C++", "Perl"
   e "Perl", "PHP"
   e "Perl", "Ruby"
   e "Ruby", "Rubinius"
   e "Ruby", "MacRuby"
   e "Ruby", "JRuby"

   %w{ Ruby JRuby MacRuby Rubinius }.each do |ruby|
      n(ruby)[:color => :tomato]
   end

   output :png => "#{$0}.png"
end

