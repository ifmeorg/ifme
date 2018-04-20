class SplineTypeException < RuntimeError
end

# spliteType or point
#
# spline ( ';' spline )*
# where spline =  (endp)? (startp)? point (triple)+
# and triple   =  point point point
# and endp  =  "e,%f,%f"
# and startp   =  "s,%f,%f"
#
# If a spline has points p1 p2 p3 ... pn, (n = 1 (mod 3)), the points correspond
# to the control points of a B-spline from p1 to pn. If startp is given, it touches
# one node of the edge, and the arrowhead goes from p1 to startp. If startp is not
# given, p1 touches a node. Similarly for pn and endp.
class GraphViz
  class Types
    class SplineType < Common
      FLOAT_MASK = /[-+]?(?:[0-9]*\.[0-9]+|[0-9]+)/
      ENDP_MASK = /e\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}/
      STARTP_MASK = /s\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}/
      POINT_MASK = /#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}(?:\s*,\s*#{FLOAT_MASK})?!?/
      TRIPLE_MASK = /#{POINT_MASK}\s+#{POINT_MASK}\s+#{POINT_MASK}/
      SPLINE_MASK = /(?:#{ENDP_MASK}\s+)?(?:#{STARTP_MASK}\s+)?#{POINT_MASK}(?:\s*#{TRIPLE_MASK})+/

      FINAL_SPLINE_MASK = /^#{SPLINE_MASK}(?:\s*;\s*#{SPLINE_MASK})*$/
      FINAL_POINT_MASK = /^#{POINT_MASK}$/

      def check(data)
        unless SPLINE_MASK.match(data).nil?
           @is_spline = true
           return data
        end
        unless FINAL_POINT_MASK.match(data).nil?
           @is_spline = false
           return data
        end
        return nil if data.empty?

        raise SplineTypeException, "Invalid spline type value"
      end

      def output
        return @data.to_s.inspect.gsub( "\\\\", "\\" )
      end

      alias :to_gv :output
      alias :to_s :output

      def point
        if point?
          "[#{@data}]".to_ruby
        else
          # TODO!
        end
      end

      def endp
      end

      def startp
      end

      def triples
      end

      private
      def point?
         not @is_spline
      end

      def splite_type?
         @is_spline
      end
    end
  end
end
