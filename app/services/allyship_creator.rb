# frozen_string_literal: true

class AllyshipCreator
  attr_reader :ally_id, :current_user, :notifier

  def initialize(args)
    @ally_id = args[:ally_id]
    @current_user = args[:current_user]
    @notifier = args[:notifier] || Allyships::AllianceNotifier
  end

  def self.perform(args = {})
    new(args).perform
  end

  def perform
    return unless valid?

    setup_allyship
    remove_request
    notifier.perform(pusher_type: pusher_type,
                     current_user: current_user,
                     ally_id: ally_id)
  end

  private

  def allyship
    return @allyship if defined?(@allyship)

    @allyship = Allyship.find_by(ally_id: ally_id, user_id: current_user.id)
  end

  def valid?
    ally_id && current_user
  end

  def pusher_type
    return 'accepted_ally_request' if allyship

    'new_ally_request'
  end

  def create_allyship
    Allyship.create(
      user_id: current_user.id,
      ally_id: ally_id,
      status: :pending_from_ally
    )
  end

  def setup_allyship
    return allyship.accepted! if allyship

    create_allyship
  end

  def remove_request
    current_user
      .notifications
      .where(uniqueid: "new_ally_request_#{ally_id}")
      .destroy_all
  end
end
