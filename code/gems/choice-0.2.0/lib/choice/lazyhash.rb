module Choice
 
  # This class lets us get away with really bad, horrible, lazy hash accessing.
  # Like so:
  #   hash = LazyHash.new
  #   hash[:someplace] = "somewhere"
  #   puts hash[:someplace]
  #   puts hash['someplace']
  #   puts hash.someplace
  #
  # If you'd like, you can pass in a current hash when initializing to convert
  # it into a lazyhash.  Or you can use the .to_lazyhash method attached to the 
  # Hash object (evil!).
  class LazyHash < Hash 
    
    # Keep the old methods around.
    alias_method :old_store, :store
    alias_method :old_fetch, :fetch
    
    # You can pass in a normal hash to convert it to a LazyHash.
    def initialize(hash = nil)
      hash.each { |key, value| self[key] = value } if !hash.nil? && hash.is_a?(Hash)
    end

    # Wrapper for []
    def store(key, value)
      self[key] = value
    end
    
    # Wrapper for []=
    def fetch(key)
      self[key]
    end

    # Store every key as a string.
    def []=(key, value)
      key = key.to_s if key.is_a? Symbol
      self.old_store(key, value)
    end
    
    # Every key is stored as a string.  Like a normal hash, nil is returned if
    # the key does not exist.
    def [](key)
      key = key.to_s if key.is_a? Symbol
      self.old_fetch(key) rescue return nil
    end

    # You can use hash.something or hash.something = 'thing' since this is
    # truly a lazy hash.
    def method_missing(meth, *args)
      meth = meth.to_s
      if meth =~ /=/
        self[meth.sub('=','')] = args.first
      else
        self[meth]
      end
    end
    
  end
end

# Really ugly, horrible, extremely fun hack.
class Hash #:nodoc: 
  def to_lazyhash
    return Choice::LazyHash.new(self) 
  end
end
