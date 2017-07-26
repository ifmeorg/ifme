RSpec.describe CompareLocalesSupport do
  let(:main_hash) {
    {
      "en"=> {
        "app_name"=>"if me",
        "app_description"=>"is a community for mental health experiences",
        "email"=>"join.ifme@gmail.com",
        "ellipsis"=>" [...]",
        "created"=>"<strong>Created:</strong> %{created_at}",
        "edited"=>"<strong>Created:</strong> %{created_at} <em>(edited)</em>",
        "edited_updated_at"=>"<strong>Created:</strong> %{created_at} <em>(edited %{updated_at})</em>",
        "salutation"=>"Hi %{name},",
        "click_here"=>"click here",
        "less"=>" [Less]",
        "language"=>"Language"
      }
    }
  }
let(:second_hash) { {"app_name"=>"if me",
"app_description"=>"is a community for mental health experiences",
"ellipsis"=>" [...]",
"created"=>"<strong>Created:</strong> %{created_at}",
"edited"=>"<strong>Created:</strong> %{created_at} <em>(edited)</em>",
"edited_updated_at"=>"<strong>Created:</strong> %{created_at} <em>(edited %{updated_at})</em>",
"salutation"=>"Hi %{name},",
"click_here"=>"click here",
"language"=>"Language"}
}
  describe '#compare_locale_hashes' do
    let(:missing) { ['less', 'email'] }
    subject(:subject) { CompareLocalesSupport.compare_locale_hashes(main_hash, second_hash) }

    it 'compares locales' do
      expect(subject).to eq(missing)
    end
  end

  describe '#flatten_keys' do
    subject(:subject) { CompareLocalesSupport.flatten_keys(main_hash) }
    let(:result) {  'en.app_name', 'en.app_description', 'en.email', 'en.ellipsis', 'en.created', 'en.edited', 'en.edited_updated_at', 'en.salutation', 'en.click_here', 'en.less', 'en.language']
 }

    it 'puts keys of the hash' do
      expect(subject).to eq(result)
    end
  end
end
