# frozen_string_literal: true

class AlliesController < ApplicationController
  # GET /allies
  # GET /allies.json
  def index
    @page_search = true
    @accepted_allies = current_user.allies_by_status(:accepted)
                                   .order('LOWER(name)')
    @incoming_ally_requests = current_user.allies_by_status(:pending_from_user)
                                          .order('LOWER(name)')
    @outgoing_ally_requests = current_user.allies_by_status(:pending_from_ally)
                                          .order('LOWER(name)')
    @invited_allies = User.where(
      invited_by_id: current_user.id, invitation_accepted_at: nil
    )
  end

  def add
    AllyshipCreator.perform(ally_id: params[:ally_id],
                            current_user:)
    redirect_to_path(allies_path)
  end

  def remove
    user_id = current_user.id
    ally_id = params[:ally_id].to_i
    Allyship.where(user_id:, ally_id:).destroy_all
    redirect_to_path(allies_path)
  end
end
