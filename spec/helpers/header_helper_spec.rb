describe HeaderHelper do
  describe '#header_props' do
    let(:mobile_only) { 'mobile_only_stub' }
    let(:profile) {
      {
        avatar: nil,
        name: current_user.name,
        profile: {
          name: 'Profile',
          url: "/profile?uid=#{current_user.uid}"
        },
        account: {
          name: 'Account',
          url: '/users/edit'
        },
        notifications: {
          plural: 'Notifications',
          none: 'There are none',
          clear: 'Clear'
        }
      }
    }
    subject { header_props }

    before(:each) do
      allow(self).to receive('mobile_only').and_return(mobile_only)
      allow(self).to receive('active?').and_return(false)
      allow(self).to receive('active?').with(active_path).and_return(active)
      allow(self).to receive('user_signed_in?').and_return(user_signed_in)
      allow(self).to receive('current_user').and_return(current_user)
    end

    context 'when user is signed in' do
      let(:current_user) { create :user2 }
      let(:user_signed_in) { true }
      let(:active_path) { resources_path }

      context 'has no active link' do
        let(:active) { false }
        it 'returns correct props' do
          expect(subject).to eq({
            home: { name: 'if me', url: '/' },
            links: [
              { name: 'About', url: '/about', active: false },
              { name: 'Blog', url: 'https://medium.com/ifme' },
              { name: 'Resources', url: '/resources', active: false },
              { name: 'Sign out', url: '/users/sign_out', dataMethod: 'delete', hideInMobile: true }
            ],
            mobileOnly: mobile_only,
            profile: profile
          })
        end
      end

      context 'has an active link' do
        let(:active) { true }
        it 'returns correct props' do
          expect(subject).to eq({
            home: { name: 'if me', url: '/' },
            links: [
              { name: 'About', url: '/about', active: false },
              { name: 'Blog', url: 'https://medium.com/ifme' },
              { name: 'Resources', url: '/resources', active: true },
              { name: 'Sign out', url: '/users/sign_out', dataMethod: 'delete', hideInMobile: true }
            ],
            mobileOnly: mobile_only,
            profile: profile
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:current_user) { nil }
      let(:user_signed_in) { false }
      let(:active_path) { new_user_session_path }

      context 'has no active link' do
        let(:active) { false }
        it 'returns correct props' do
          expect(subject).to eq({
            home: { name: 'if me', url: '/' },
            links: [
              { name: 'About', url: '/about', active: false },
              { name: 'Blog', url: 'https://medium.com/ifme' },
              { name: 'Resources', url: '/resources', active: false },
              { name: 'Join', url: '/users/sign_up', active: false },
              { name: 'Sign in', url: '/users/sign_in', active: false }
            ],
            mobileOnly: nil,
            profile: nil
          })
        end
      end

      context 'has an active link' do
        let(:active) { true }
        it 'returns correct props' do
          expect(subject).to eq({
            home: { name: 'if me', url: '/' },
            links: [
              { name: 'About', url: '/about', active: false },
              { name: 'Blog', url: 'https://medium.com/ifme' },
              { name: 'Resources', url: '/resources', active: false },
              { name: 'Join', url: '/users/sign_up', active: false },
              { name: 'Sign in', url: '/users/sign_in', active: true }
            ],
            mobileOnly: nil,
            profile: nil
          })
        end
      end
    end
  end
end
