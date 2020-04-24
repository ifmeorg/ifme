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

  subject(:keywords) { MomentKeywords.new(moment).call }

  it 'downcases words' do
    expect(keywords).to include('addiction')
  end

  it 'removes special characters' do
    expect(keywords).to include('teachers')
  end

  it 'sanitizes html tags' do
    expect(keywords).to include('blog')
  end

  it 'returns a string with all keywords' do
    expect(keywords).to eq(
                            'free description name blog name books addiction self-care teachers'
                        )
  end
end
