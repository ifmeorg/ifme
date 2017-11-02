# frozen_string_literal: true

module InvitationsHelper
  def inviter_name(resource)
    User.where(id: resource.invited_by_id).first.presence.try(:name) ||
      'Someone'
  end
end
