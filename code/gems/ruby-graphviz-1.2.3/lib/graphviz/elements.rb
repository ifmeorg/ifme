class GraphViz
  class Elements
    def initialize
      @elements = Array.new
      @elements_hash_by_type = Hash.new
    end

    def push( obj )
      @elements.push( obj )
      if @elements_hash_by_type[obj['type']].nil?
        @elements_hash_by_type[obj['type']] = Array.new
      end

      @elements_hash_by_type[obj['type']].push( obj )
    end

    def each( &b )
      @elements.each do |e|
        yield( e )
      end
    end

    def size_of( type )
      if @elements_hash_by_type[type].nil?
        return 0
      else
        return @elements_hash_by_type[type].size
      end
    end

    def []( index, type = nil )
      if type.nil?
        return @elements[index]
      else
        return @elements_hash_by_type[type][index]
      end
    end
  end
end