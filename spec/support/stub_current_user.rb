module StubCurrentUserHelper
  def stub_current_user_with(user)
    allow(controller).to receive(:user_signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  def stub_current_user
    build_stubbed(:user1).tap do |user|
      stub_current_user_with(user)
    end
  end

  def create_current_user
    create(:user1).tap do |user|
      stub_current_user_with(user)
    end
  end
end
