describe Sentimental do
  # TODO: once I figure out classes then we can base class and use the correct name
  before(:each) do
    # Create an instance for usage
    @analyzer = Sentimental.new

    # Load the default sentiment dictionaries
    @analyzer.load_defaults

    # And/or load your own dictionaries
    # analyzer.load_senti_file('path/to/your/file.txt')

    # Set a global threshold
    @analyzer.threshold = 0.5
  end

  it 'parses sentiment in the ambivalent string' do
    text = 'I am super sad right now, entering this moment to feel better.'
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    puts @analyzer.sentiment(text)
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'

    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    puts @analyzer.explain(text)
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
  end

  it 'parses positive sentiment' do
    text = 'Today was awesome, did a lot of productive things.'
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    puts @analyzer.sentiment(text)
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'

    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    puts @analyzer.explain(text)
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
  end

  it 'parses negative sentiment' do
    text = 'Life sucks, this blows, xyz happened and I should have not been angry.'
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    puts @analyzer.sentiment(text)
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'

    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    puts @analyzer.explain(text)
    puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
  end
end
