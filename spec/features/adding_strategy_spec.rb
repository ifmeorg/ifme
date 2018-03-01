describe "user adds a new strategy" do
  let!(:user) { FactoryBot.create(:user_oauth) }
  before do
    login_as user
    visit new_strategy_path
  end

  it "creates a new strategy" do
    fill_in "Title", with: "A strategy name"
    fill_in "Describe the strategy", with: "A description"
    click_on "Submit"
    expect(page).to have_content("A strategy name")
    new_strategy = user.strategies.last
    expect(new_strategy.name).to eq("A strategy name")
    expect(new_strategy.perform_strategy_reminder.active?).to eq(false)
  end

  context "and turns on reminders" do
    it "creates a new strategy with reminders" do
      fill_in "Title", with: "A strategy name"
      fill_in "Describe the strategy", with: "A description"
      find(:css, "#perform_strategy_reminder").set(true)
      click_on "Submit"
      expect(page).to have_content("A strategy name")
      new_strategy = user.strategies.last
      expect(new_strategy.perform_strategy_reminder.active?).to eq(true)
    end
  end
end
