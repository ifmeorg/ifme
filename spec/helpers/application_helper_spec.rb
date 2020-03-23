# frozen_string_literal: true
describe ApplicationHelper do
  describe '#html_options' do
    it 'returns correct hash' do
      expect(html_options).to eq(class: 'htmlOptions')
    end
  end

  describe '#active?' do
    let(:is_current_page) { false }
    let(:current_controller) { '' }
    let(:action_name) { '' }
    let(:path) { root_path }
    let(:environment) { {} }

    subject { active?(path, environment) }

    before(:each) do
      params[:controller] = current_controller
      allow(controller).to receive(:action_name).and_return(action_name)
      allow(self).to receive('current_page?').and_return(is_current_page)
    end

    context 'current page' do
      let(:is_current_page) { true }
      it { is_expected.to be true }
    end

    context 'current controller' do
      let(:current_controller) { 'moments' }
      let(:path)               { new_moment_path }

      it { is_expected.to be true }
    end

    context 'current controller and profile' do
      let(:current_controller) { 'profile' }
      let(:path)               { 'profile?user_id=2' }

      it { is_expected.to be false }
    end

    context 'current controller and about' do
      let(:current_controller) { 'pages' }
      let(:path)               { 'about' }

      it { is_expected.to be false }
    end

    context 'new user session with devise' do
      let(:current_controller) { 'sessions' }
      let(:action_name)        { 'new' }
      let(:path)               { new_user_session_path }

      it { is_expected.to be true }
    end

    context 'new user registration with devise' do
      let(:current_controller) { 'registrations' }
      let(:action_name)        { 'create' }
      let(:path)               { new_user_registration_path }

      it { is_expected.to be true }
    end

    context 'sign out' do
      let(:current_controller) { 'profile' }
      let(:path)               { destroy_user_session_path }
      let(:environment)        { { method: :delete } }

      it { is_expected.to be false }
    end
  end

  describe 'sign_in_path?' do
    let(:page) { '' }
    let(:current_controller) { '' }
    let(:action_name) { '' }
    subject { sign_in_path? }

    before(:each) do
      params[:controller] = current_controller
      allow(self).to receive('action_name').and_return(action_name)
      allow(self).to receive('current_page?').and_return(false)
      allow(self).to receive('current_page?').with(page).and_return(true)
    end

    context 'when the path matches' do
      let(:page) { new_user_session_path }
      it { is_expected.to be true }
    end

    context 'when the controller and action match' do
      let(:current_controller) { 'sessions' }
      let(:action_name) { 'new' }
      it { is_expected.to be true }
    end

    context 'when the path does not match' do
      let(:page) { about_path }
      it { is_expected.to be false }
    end
  end

  describe 'join_path?' do
    let(:page) { '' }
    let(:current_controller) { '' }
    let(:action_name) { '' }
    subject { join_path? }

    before(:each) do
      params[:controller] = current_controller
      allow(self).to receive('action_name').and_return(action_name)
      allow(self).to receive('current_page?').and_return(false)
      allow(self).to receive('current_page?').with(page).and_return(true)
    end

    context 'when the path matches' do
      let(:page) { new_user_registration_path }
      it { is_expected.to be true }
    end

    context 'when the controller and action match the path' do
      let(:current_controller) { 'registrations' }
      let(:action_name) { 'create' }
      it { is_expected.to be true }
    end

    context 'when the path does not match' do
      let(:page) { about_path }
      it { is_expected.to be false }
    end
  end

  describe 'forgot_password_path?' do
    let(:page) { '' }
    let(:current_controller) { '' }
    let(:action_name) { '' }
    subject { forgot_password_path? }

    before(:each) do
      params[:controller] = current_controller
      allow(self).to receive('action_name').and_return(action_name)
      allow(self).to receive('current_page?').and_return(false)
      allow(self).to receive('current_page?').with(page).and_return(true)
    end

    context 'when the path matches' do
      let(:page) { new_user_password_path }
      it { is_expected.to be true }
    end

    context 'when the controller and action match the path' do
      let(:current_controller) { 'devise/passwords' }
      let(:action_name) { 'new' }
      it { is_expected.to be true }
    end

    context 'when the path does not match' do
      let(:page) { about_path }
      it { is_expected.to be false }
    end
  end

  describe 'update_account_path?' do
    let(:page) { '' }
    let(:current_controller) { '' }
    let(:action_name) { '' }
    subject { update_account_path? }

    before(:each) do
      params[:controller] = current_controller
      allow(self).to receive('action_name').and_return(action_name)
      allow(self).to receive('current_page?').and_return(false)
      allow(self).to receive('current_page?').with(page).and_return(true)
    end

    context 'when the path matches' do
      let(:page) { edit_user_registration_path }
      it { is_expected.to be true }
    end

    context 'when the controller and action match the path' do
      let(:current_controller) { 'registrations' }
      let(:action_name) { 'update' }
      it { is_expected.to be true }
    end

    context 'when the path does not match' do
      let(:page) { about_path }
      it { is_expected.to be false }
    end
  end

  describe 'not_signed_in_root_path?' do
    let(:page) { '' }
    let (:user_signed_in) { true }
    subject { not_signed_in_root_path? }

    before(:each) do
      allow(self).to receive('user_signed_in?').and_return(user_signed_in)
      allow(self).to receive('current_page?').and_return(false)
      allow(self).to receive('current_page?').with(page).and_return(true)
    end

    context 'when the path matches and user is not signed in' do
      let(:page) { root_path }
      let(:user_signed_in) { false }
      it { is_expected.to be true }
    end

    context 'when the path matches and user is signed in' do
      let(:page) { root_path }
      it { is_expected.to be false }
    end

    context 'when the path does not match' do
      let(:page) { about_path }
      it { is_expected.to be false }
    end
  end

  describe 'send_ally_invitation_path?' do
    let(:page) { '' }
    let(:current_controller) { '' }
    let(:action_name) { '' }
    subject { send_ally_invitation_path? }

    before(:each) do
      params[:controller] = current_controller
      allow(self).to receive('action_name').and_return(action_name)
      allow(self).to receive('current_page?').and_return(false)
      allow(self).to receive('current_page?').with(page).and_return(true)
    end

    context 'when the path matches' do
      let(:page) { new_user_invitation_path }
      it { is_expected.to be true }
    end

    context 'when the controller and action match the path' do
      let(:current_controller) { 'devise/invitations' }
      let(:action_name) { 'new' }
      it { is_expected.to be true }
    end

    context 'when another controller and action match the path' do
      let(:current_controller) { 'users/invitations' }
      let(:action_name) { 'create' }
      it { is_expected.to be true }
    end

    context 'when the path does not match' do
      let(:page) { about_path }
      it { is_expected.to be false }
    end
  end

  describe 'ally_accept_invitation_path?' do
    let(:page) { '' }
    let(:current_controller) { '' }
    let(:action_name) { '' }
    subject { ally_accept_invitation_path? }

    before(:each) do
      params[:controller] = current_controller
      allow(self).to receive('action_name').and_return(action_name)
      allow(self).to receive('current_page?').and_return(false)
      allow(self).to receive('current_page?').with(page).and_return(true)
    end

    context 'when the path matches' do
      let(:page) { accept_user_invitation_path }
      it { is_expected.to be true }
    end

    context 'when the controller and action match the path' do
      let(:current_controller) { 'users/invitations' }
      let(:action_name) { 'update' }
      it { is_expected.to be true }
    end

    context 'when the path does not match' do
      let(:page) { about_path }
      it { is_expected.to be false }
    end
  end

  describe 'reset_password_path?' do
    let(:page) { '' }
    let(:current_controller) { '' }
    let(:action_name) { '' }
    subject { reset_password_path? }

    before(:each) do
      params[:controller] = current_controller
      allow(self).to receive('action_name').and_return(action_name)
      allow(self).to receive('current_page?').and_return(false)
      allow(self).to receive('current_page?').with(page).and_return(true)
    end

    context 'when the path matches' do
      let(:page) { edit_user_password_path }
      it { is_expected.to be true }
    end

    context 'when the controller and action match the path' do
      let(:current_controller) { 'devise/passwords' }
      let(:action_name) { 'edit' }
      it { is_expected.to be true }
    end

    context 'when the path does not match' do
      let(:page) { about_path }
      it { is_expected.to be false }
    end
  end

  describe 'secret_share_path?' do
    let(:page) { '' }
    let(:current_controller) { '' }
    let(:action_name) { '' }
    let(:moment) { create(:moment, :with_user, :with_secret_share) }
    subject { secret_share_path? }

    before(:each) do
      params[:controller] = current_controller
      allow(self).to receive('action_name').and_return(action_name)
      allow(self).to receive('current_page?').and_return(false)
      allow(self).to receive('current_page?').with(page).and_return(true)
    end

    context 'when the path matches' do
      let(:current_controller) { 'secret_shares' }
      let(:action_name) { 'show' }
      let(:page) { secret_share_path(id: moment.id) }
      it { is_expected.to be true }
    end

    context 'when the path does not match' do
      let(:page) { about_path }
      it { is_expected.to be false }
    end
  end

  describe '#static_page?' do
    subject { static_page? }

    before(:each) do
      allow(self).to receive('current_page?').and_return(false)
      allow(self).to receive('current_page?').with(page).and_return(true)
    end

    context 'non-devise is the active page' do
      context 'when it is a static page' do
        let(:page) { about_path }
        it { is_expected.to be true }
      end

      context 'when it is not a static page' do
        let(:page) { moments_path }
        it { is_expected.to be false }
      end
    end

    context 'devise path is the active page' do
      context 'when it is a static page' do
        let(:page) { accept_user_invitation_path }
        it { is_expected.to be true }
      end

      context 'when it is not a static page' do
        let(:page) { new_user_password_path }
        it { is_expected.to be false }
      end
    end
  end

  describe '#get_icon_class' do
    context 'when icon is nil' do
      it 'returns default globe icon' do
        expect(get_icon_class(nil)).to eq('fa fa-globe')
      end
    end

    context 'when icon exists' do
      it 'returns correct icons' do
        fas = %w[envelope gift rss]
        far = %w[money-bill-alt]
        fab = %w[facebook github instagram medium twitter]
        icons = [{ fas: fas }, { far: far }, { fab: fab }]
        icons.each do |icon_set|
          icon_set.values[0].each do |icon|
            expect(get_icon_class(icon)).to eq("#{icon_set.keys[0]} fa-#{icon}")
          end
        end
      end
    end
  end
end
