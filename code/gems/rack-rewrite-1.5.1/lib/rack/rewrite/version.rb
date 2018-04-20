module Rack
  class Rewrite
    VERSION = File.read File.join(File.expand_path("..", __FILE__), "..", "..", "..", "VERSION")
  end
end