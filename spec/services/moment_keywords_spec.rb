describe MomentKeywords do
  let(:moment) do
    FactoryBot.build(
        :moment,
        categories: [build(:category, name: 'free', description: 'Description')],
        moods: [build(:mood, name: 'Name', description: 'Blog^^')],
        strategies: [build(:strategy, name: 'Name', description: 'books@!##.')],
        name: 'ADDICTION',
        why: 'self-care.',
        fix: '@Teachers!!'
    )
  end

  subject(:keywords) { MomentKeywords.new(moment).call }

  it 'downcases words' do
    expect(keywords).to include('addiction')
  end

  it 'removes hyphen from compound words' do
    expect(keywords).to include('self care')
  end

  it 'removes special characters' do
    expect(keywords).to include('teachers')
  end

  it 'returns an array of all the key words' do
    expect(keywords).to eq(
                            ['free', 'description','name', 'blog', 'name', 'books',
                             'addiction', 'self care', 'teachers']
                        )
  end
end
