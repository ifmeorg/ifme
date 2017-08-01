# frozen_string_literal: true

RSpec.describe CompareLocalesSupport do
  main_hash = {
    'en' => {
      'app_name'=>'if me',
      'app_description'=>'is a community for mental health experiences',
      'email'=>'join.ifme@gmail.com',
      'ellipsis'=>'[...]',
      'created'=>'<strong>Created:</strong> %{created_at}',
      'edited'=>'<strong>Created:</strong> %{created_at} <em>(edited)</em>',
      'salutation'=>'Hi %{name},',
      'click_here'=>'click here',
      'less'=>'[Less]',
      'language'=>'Language'
    }
  }

  second_hash = {
    'en' => {
      'app_name'=>'if me',
      'app_description'=>'is a community for mental health experiences',
      'ellipsis'=>'[...]',
      'created'=>'<strong>Created:</strong> %{created_at}',
      'edited'=>'<strong>Created:</strong> %{created_at} <em>(edited)</em>',
      'salutation'=>'Hi %{name},',
      'click_here'=>'click here',
      'language'=>'Language'
    }
  }

  describe 'compare default locale files' do

    specify 'spanish locale file has nothing missing' do
      english = './config/locales/en.yml'
      spanish = './config/locales/es.yml'
      expect(CompareLocalesSupport.compare(english, spanish)).to match_array([])
    end

    specify 'portuguese locale file has nothing missing' do
      english ='./config/locales/en.yml'
      portuguese ='./config/locales/ptbr.yml'
      expect(CompareLocalesSupport.compare(english, portuguese)).to match_array([])
    end
  end

  describe 'compare default devise locale files' do

    specify 'spanish  devise locale file has nothing missing' do
      english = './config/locales/devise.en.yml'
      spanish = './config/locales/devise.es.yml'
      expect(CompareLocalesSupport.compare(english, spanish)).to match_array([])
    end

    specify 'portuguese devise locale file has nothing missing' do
      english ='./config/locales/devise.en.yml'
      portuguese ='./config/locales/devise.ptbr.yml'
      expect(CompareLocalesSupport.compare(english, portuguese)).to match_array([])
    end
  end

  describe 'compare default devise invitable locale files' do

    specify 'spanish devise invitable locale file has nothing missing' do
      english = './config/locales/devise_invitable.en.yml'
      spanish = './config/locales/devise_invitable.es.yml'
      expect(CompareLocalesSupport.compare(english, spanish)).to match_array([])
    end

    specify 'portuguese devise invitable locale file has nothing missing' do
      english ='./config/locales/devise_invitable.en.yml'
      portuguese ='./config/locales/devise_invitable.ptbr.yml'
      expect(CompareLocalesSupport.compare(english, portuguese)).to match_array([])
    end
  end

  describe 'compare kaminari locale files' do

    specify 'spanish kaminari locale file has nothing missing' do
      english = './config/locales/kaminari.en.yml'
      spanish = './config/locales/kaminari.es.yml'
      expect(CompareLocalesSupport.compare(english, spanish)).to match_array([])
    end

    specify 'portuguese kaminari locale file has nothing missing' do
      english ='./config/locales/kaminari.en.yml'
      portuguese ='./config/locales/kaminari.ptbr.yml'
      expect(CompareLocalesSupport.compare(english, portuguese)).to match_array([])
    end
  end

  describe '#compare_locale_hashes' do
    let(:missing) { %w[less email] }
    subject(:subject) { CompareLocalesSupport.compare_locale_hashes(main_hash, second_hash) }

    it 'compares locales' do
      expect(subject).to match_array(missing)
    end
  end

  describe '#flatten_keys' do
    subject(:subject) { CompareLocalesSupport.flatten_keys(main_hash) }
    let(:result) do
      ['en.app_name', 'en.app_description', 'en.email', 'en.ellipsis', 'en.created', 'en.edited', 'en.salutation', 'en.click_here', 'en.less', 'en.language']
    end

    it 'puts keys of the hash' do
      expect(subject).to eq(result)
    end
  end
end
