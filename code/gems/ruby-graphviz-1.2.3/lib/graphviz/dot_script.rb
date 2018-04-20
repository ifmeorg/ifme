require "forwardable"
class GraphViz

  class DOTScriptData
    attr_accessor :type
    def initialize(type = nil)
      @data = []
      @separator = ""
      @type = type
    end

    def append(data)
      @data << data
    end
    alias :<< :append

    def add_attribute(name, value)
      @data << @separator << name << " = " << value
      @separator = determine_separator
    end

    def to_str
      case @type
        when "graph_attr" then "#{@data.join}#{@separator}"
        when "node_attr" then "node[#{@data.join(' ')}];"
        when "edge_attr" then "edge[#{@data.join(' ')}];"
        else raise ArgumentError, "Wrong type: #{@type}."
      end
    end
    alias :to_s :to_str

    def empty?
      @data.empty?
    end

    private

    def determine_separator
      case @type
        when "graph_attr"             then ";\n"
        when "node_attr", "edge_attr" then ","
        else raise ArgumentError, "Wrong type: #{@type}."
      end
    end

  end

  class DOTScript
    extend Forwardable

    def_delegators :@script, :end_with?

    def initialize
      @script = ''
    end

    def append(line)
      @script << assure_ends_with(line.to_s,"\n")

      self
    end
    alias :<< :append

    def prepend(line)
      @script = assure_ends_with(line.to_s,"\n") + @script

      self
    end

    def make_subgraph(name)
      prepend(assure_ends_with("subgraph #{name}"," {"))
    end

    def add_type(type, data)
      return self if data.empty?

      case type
      when "graph_attr"
        append_statement("  " + data)
      when "node_attr"
        append_statement("  node [" + data + "]")
      when "edge_attr"
        append_statement("  edge [" + data + "]")
      else
        raise ArgumentError,
          "Unknown type: #{type}." <<
          "Possible: 'graph_attr','node_attr','edge_attr'"
      end

      self
    end

    def to_str
      @script
    end
    alias :to_s :to_str

    private

    def assure_ends_with(str,ending="\n")
      str.to_s.end_with?("\n") ? str : str + ending
    end

    def append_statement(statement)
      append(assure_ends_with(statement, ";\n"))
    end

  end
end
