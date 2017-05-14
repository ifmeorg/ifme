RSpec.describe PagesHelper, type: :helper do
  describe '#print_contributors' do
    it 'returns empty result for empty array' do
      expect(print_contributors([])).to eq('')
    end

    it 'returns empty result for malformed array' do
      expect(print_contributors(['test'])).to eq('')
      expect(print_contributors([['test']])).to eq('')
    end

    it 'returns correct result for one link' do
      list = [{ 'name' => 'test', 'link' => 'http://if-me.org' }]

      link = '<a target="blank" href="http://if-me.org">test</a>'
      expect(print_contributors(list)).to eq(link)
    end

    it 'returns correct result for two links' do
      list = [
        { 'name' => 'test1', 'link' => 'http://if-me.org' },
        { 'name' => 'test2', 'link' => 'http://if-me2.org' }
      ]

      link1 = '<a target="blank" href="http://if-me.org">test1</a>'
      link2 = '<a target="blank" href="http://if-me2.org">test2</a>'
      expect(print_contributors(list)).to eq("#{link1} and #{link2}")
    end

    it 'returns correct result for a sentence of links' do
      list = [
        { 'name' => 'test1', 'link' => 'http://if-me.org' },
        { 'name' => 'test2', 'link' => 'http://if-me2.org' },
        { 'name' => 'test3', 'link' => 'http://if-me3.org' }
      ]

      link1 = '<a target="blank" href="http://if-me.org">test1</a>'
      link2 = '<a target="blank" href="http://if-me2.org">test2</a>'
      link3 = '<a target="blank" href="http://if-me3.org">test3</a>'
      expect(print_contributors(list)).to eq("#{link1}, #{link2}, and #{link3}")
    end
  end

  describe '#print_partners' do
    it 'returns empty result for empty array' do
      expect(print_partners([])).to eq('')
    end

    it 'returns empty result for malformed array' do
      list = [{ 'name' => 'test', 'link' => 'http://if-me.org' }]

      expect(print_partners(list)).to eq('')
      expect(print_partners(['test'])).to eq('')
      expect(print_partners([['test']])).to eq('')
    end

    it 'returns correct result for one link' do
      list = [{ 'name' => 'test', 'link' => 'http://if-me.org',
                'image_link' => 'test.png' }]

      expect(print_partners(list)).to eq(
        '<div class="partner">' \
          '<a target="blank" href="http://if-me.org">' \
            '<img alt="test" src="/images/test.png" />' \
          '</a>' \
        '</div>'
      )
    end

    it 'returns correct result for two links' do
      list = [
        { 'name' => 'test1', 'link' => 'http://if-me.org',
          'image_link' => 'test1.png' },
        { 'name' => 'test2', 'link' => 'http://if-me.org',
          'image_link' => 'test1.png' }
      ]

      expect(print_partners(list)).to eq(
        '<div class="partner">' \
          '<a target="blank" href="http://if-me.org">' \
            '<img alt="test1" src="/images/test1.png" />' \
          '</a>' \
        '</div>' \
        '<div class="spacer"></div>' \
        '<div class="partner">' \
          '<a target="blank" href="http://if-me.org">' \
            '<img alt="test2" src="/images/test1.png" />' \
          '</a>' \
        '</div>'
      )
    end
  end
end
