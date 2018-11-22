# frozen_string_literal: true
module AllyConcern
  extend ActiveSupport::Concern

  ALLY_STATUS = {
    accepted: 0, pending_from_user: 1, pending_from_ally: 2
  }.freeze

  def ally?(user)
    allies_by_status(:accepted).include?(user)
  end

  def allies_by_status(status)
    allyships.includes(:ally).where(status: ALLY_STATUS[status])
             .map(&:ally).reject(&:banned)
  end

  def available_groups(order)
    ally_groups.order(order) - groups
  end

  def mutual_allies?(user)
    ally?(user) && user.ally?(self)
  end

  private

  def accepted_ally_ids
    allyships.where(status: ALLY_STATUS[:accepted]).pluck(:ally_id)
  end

  def ally_groups
    Group.includes(:group_members)
         .where(group_members: { user_id: accepted_ally_ids })
  end
end
