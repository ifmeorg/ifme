RSpec.describe CompareLocalesHelper, type: :helper do

  describe '#compare' do
    let(:locale_1) { './config/locales/en.yml' }
    let(:locale_2) { './config/locales/es.yml' }
    subject(:subject) { helper.compare(locale_1, locale_2) }

    it 'compares locales' do
      expect(subject).to eq('')
    end
  end

  describe '#flatten_keys' do
    let(:hash) { {"app_name"=>"if me",
 "app_description"=>"is a community for mental health experiences",
 "email"=>"join.ifme@gmail.com",
 "ellipsis"=>" [...]",
 "created"=>"<strong>Created:</strong> %{created_at}",
 "edited"=>"<strong>Created:</strong> %{created_at} <em>(edited)</em>",
 "edited_updated_at"=>"<strong>Created:</strong> %{created_at} <em>(edited %{updated_at})</em>",
 "salutation"=>"Hi %{name},",
 "click_here"=>"click here",
 "less"=>" [Less]",
 "language"=>"Language"}
 }
    subject(:subject) { helper.flatten_keys(hash, prefix="") }
    let(:result) {  ["app_name", "app_description", "email", "ellipsis", "created", "edited", "edited_updated_at", "salutation", "click_here", "less", "language"]
 }

    it 'puts keys of the hash' do
      expect(subject).to eq(result)
    end
  end
end
