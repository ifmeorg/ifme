describe AvatarUploader do
  let(:user) { create(:user) }

  it 'wont upload if there is already an avatar' do
    allow(user.avatar).to receive(:file).and_return('moment.jpeg')
    allow(user.avatar.file).to receive(:exists?).and_return(true)

    expect(user).not_to receive(:remote_avatar_url=)

    AvatarUploader.set_avatar_from_url!(user, 'http://example.com/images/profile.jpeg')
  end

  it 'uploads when avatar is blank' do
    expect(user).to receive(:remote_avatar_url=)

    AvatarUploader.set_avatar_from_url!(user, 'http://example.com/images/profile.jpeg')
  end
end
