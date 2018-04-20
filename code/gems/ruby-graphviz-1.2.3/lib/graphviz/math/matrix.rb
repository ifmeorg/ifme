class GraphViz
  class Math
    def self.Matrix( line, column = 0, val = 0 )
      GraphViz::Math::Matrix.new(line, column, val)
    end

    class CoordinateError < RuntimeError
    end
    class ValueError < RuntimeError
    end

    class Matrix
      def initialize( line_or_array, column = 0, val = 0 )
        if line_or_array.kind_of?(Array)
          line = line_or_array.size
          column = nil
          line_or_array.size.times do |l|
            unless line_or_array[l].kind_of?(Array)
              raise ArgumentError, "Wrong matrix definition"
            end
            column = line_or_array[l].size if column.nil?
            unless line_or_array[l].size == column
              raise ArgumentError, "Wrong matrix definition"
            end
            line_or_array[l].size.times do |c|
              unless line_or_array[l][c].kind_of?(Numeric)
                raise ValueError, "Element at [#{l+1}, #{c+1}] is not a number"
              end
            end
          end

          @matrix = line_or_array
          @line = line
          @column = column
        elsif line_or_array.kind_of?(Integer) and column > 0
          @matrix = Array.new(line_or_array)
          @matrix.size.times do |l|
            @matrix[l] = Array.new(column)
            @matrix[l].size.times do |c|
              @matrix[l][c] = val
            end
          end
          @line = line_or_array
          @column = column
        else
          raise ArgumentError, "Wrong matrix definition"
        end
      end

      def [](line, column)
        unless (0...@line).to_a.include?(line-1)
          raise CoordinateError, "Line out of range (#{line} for 1..#{@line})!"
        end
        unless (0...@column).to_a.include?(column-1)
          raise CoordinateError, "Column out of range (#{column} for 1..#{@column})!"
        end
        @matrix[line-1][column-1]
      end

      def []=( line, column, val )
        unless (0...@line).to_a.include?(line-1)
          raise CoordinateError, "Line out of range (#{line} for 1..#{@line})!"
        end
        unless (0...@column).to_a.include?(column-1)
          raise CoordinateError, "Column out of range (#{column} for 1..#{@column})!"
        end
        @matrix[line-1][column-1] = val
      end

      def matrix
        @matrix
      end
      alias :to_a :matrix

      def columns
        @column
      end

      def lines
        @line
      end

      def to_s
        size = bigger
        out = ""
        @line.times do |line|
          out << "["
          @column.times do |column|
            out << sprintf(" %1$*2$s", @matrix[line][column].to_s, size)
          end
          out << "]\n"
        end
        return out
      end

      def -(m)
        matrix = GraphViz::Math::Matrix.new( @line, @column )
        @line.times do |line|
          @column.times do |column|
            matrix[line+1, column+1] = self[line+1, column+1] - m[line+1, column+1]
          end
        end
        return matrix
      end

      def *(m)
        matrix = GraphViz::Math::Matrix.new( @line, @line )

        @line.times do |line|
          @line.times do |column|
            l = self.line(line+1)
            c = m.column(column+1)
            v = 0
            l.size.times do |i|
              v += l[i]*c[i]
            end
            matrix[line+1,column+1] = v
          end
        end

        return matrix
      end

      def line( line )
        unless (0...@line).to_a.include?(line-1)
          raise CoordinateError, "Line out of range (#{line} for 1..#{@line})!"
        end
        @matrix[line-1]
      end

      def column( column )
        col = []
        unless (0...@column).to_a.include?(column-1)
          raise CoordinateError, "Column out of range (#{column} for 1..#{@column})!"
        end
        @line.times do |line|
          col << self[line+1, column]
        end

        return col
      end

      def transpose
        matrix = GraphViz::Math::Matrix.new( @column, @line )
        @line.times do |line|
          @column.times do |column|
            matrix[column+1, line+1] = self[line+1, column+1]
          end
        end
        return matrix
      end

      def ==(m)
        equal = true
        @line.times do |line|
          @column.times do |column|
            equal &&= (m[line+1, column+1] == self[line+1, column+1])
          end
        end
        return equal
      end

      def remove_line(n)
        unless (0...@line).to_a.include?(n-1)
          raise CoordinateError, "Line out of range (#{n} for 1..#{@line})!"
        end

        matrix = GraphViz::Math::Matrix.new( @line - 1, @column )
        nline = 0
        @line.times do |line|
          next if line == n - 1
          @column.times do |column|
            matrix[nline+1, column+1] = self[line+1, column+1]
          end
          nline += 1
        end
        return matrix
      end

      def remove_column(n)
        unless (0...@column).to_a.include?(n-1)
          raise CoordinateError, "Column out of range (#{n} for 1..#{@column})!"
        end

        matrix = GraphViz::Math::Matrix.new( @line, @column - 1 )
        @line.times do |line|
          ncolumn = 0
          @column.times do |column|
            next if column == n - 1
            matrix[line+1, ncolumn+1] = self[line+1, column+1]
            ncolumn += 1
          end
        end
        return matrix
      end

      def sum_of_column(n)
        column(n).inject(0){|sum,item| sum + item}
      end

      def sum_of_line(n)
        line(n).inject(0){|sum,item| sum + item}
      end

      def set_matrix(m) #:nodoc:
        @matrix = m
      end

      private
      def bigger
        b = 0
        @matrix.each do |line|
          line.each do |column|
            b = column.to_s.size if column.to_s.size > b
          end
        end
        return b
      end
    end
  end
end
