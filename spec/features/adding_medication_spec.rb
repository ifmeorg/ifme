require "spec_helper"
require "rails_helper"

describe "user adds a new medication" do
  let!(:user) { FactoryGirl.create(:user_oauth) }
  before do
    login_as user
    visit new_medication_path
  end

  it "creates a new medication" do
    fill_in "Name", with: "A medication name"
    fill_in "medication_comments", with: "A comment"
    fill_in "Strength", with: 100
    fill_in "Total", with: 30
    fill_in "Dosage", with: 2
    fill_in "Refill", with: "05/25/2016"
    click_on "Create Medication"
    expect(page).to have_content("A medication name")
    new_medication = user.medications.last
    expect(new_medication.name).to eq("A medication name")
    expect(new_medication.take_medication_reminder.active?).to eq(false)
    expect(new_medication.refill_reminder.active?).to eq(false)
  end

  context "and turns on reminders" do
    it "creates a new medication with reminders" do
      fill_in "Name", with: "A medication name"
      fill_in "medication_comments", with: "A comment"
      fill_in "Strength", with: 100
      fill_in "Total", with: 30
      fill_in "Dosage", with: 2
      fill_in "Refill", with: "05/25/2016"
      find(:css, "#take_medication_reminder").set(true)
      find(:css, "#refill_reminder").set(true)
      click_on "Create Medication"
      expect(page).to have_content("A medication name")
      new_medication = user.medications.last
      expect(new_medication.take_medication_reminder.active?).to eq(true)
      expect(new_medication.refill_reminder.active?).to eq(true)
    end
  end

  it "creates a new medication with Google Calendar reminder" do
    fill_in "Name", with: "A medication name"
    fill_in "medication_comments", with: "A comment"
    fill_in "Strength", with: 100
    fill_in "Total", with: 30
    fill_in "Dosage", with: 30
    fill_in "Refill", with: "05/25/2016"
    find(:css, "#take_medication_reminder").set(true)
    find(:css, "#refill_reminder").set(true)
    find(:css, "#medication_add_to_google_cal").set(true)
    click_on "Create Medication"
    expect(page).to have_content("A medication name")
    new_medication = user.medications.last
    expect(new_medication.take_medication_reminder.active?).to eq(true)
    expect(new_medication.refill_reminder.active?).to eq(true)
  end
end
