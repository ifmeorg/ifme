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
end
