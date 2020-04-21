describe MomentKeywords do
  let(:moment) do
    FactoryBot.build(
        :moment,
        categories: [build(:category, name: 'free', description: '<div>Description</div>')],
        moods: [build(:mood, name: 'Name', description: '<div>Blog^^</div>')],
        strategies: [build(:strategy, name: 'Name', description: '<div>books@!##.</div>')],
        name: 'ADDICTION',
        why: '<div>self-care.<\div>',
        fix: '<div>@Teachers!!<\div>'
    )
  end

  subject(:keywords) { MomentKeywords.new(moment).assemble }

  it 'downcases words' do
    expect(keywords).to include('addiction')
  end

  it 'removes hyphen from compound words' do
    expect(keywords).to include('self care')
  end

  it 'removes special characters' do
    expect(keywords).to include('teachers')
  end

  it 'sanitizes html tags' do
    expect(keywords).to include('blog')
  end

  it 'returns an array of all the key words' do
    expect(keywords).to eq(
                            ['free', 'description','name', 'blog', 'name', 'books',
                             'addiction', 'self care', 'teachers']
                        )
  end
end
