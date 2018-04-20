require_relative 'constants'

module Unicode
  module DisplayWidth
    INDEX = Marshal.load(Gem.gunzip(File.binread(INDEX_FILENAME)))
  end
end
