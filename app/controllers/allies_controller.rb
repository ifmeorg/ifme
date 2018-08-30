# frozen_string_literal: true

class AlliesController < ApplicationController
  # GET /allies
  # GET /allies.json
  def index
    @page_search = true
    @accepted_allies = current_user.allies_by_status(:accepted)
                                   .sort_by! { |n| n.name.downcase }
    @incoming_ally_requests = current_user.allies_by_status(:pending_from_user)
                                          .sort_by! { |n| n.name.downcase }
    @outgoing_ally_requests = current_user.allies_by_status(:pending_from_ally)
                                          .sort_by! { |n| n.name.downcase }
  end

  def add
    AllyshipCreator.perform(ally_id: params[:ally_id],
                            current_user: current_user)

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def remove
    user_id = current_user.id
    ally_id = params[:ally_id].to_i

    Allyship.where(user_id: user_id, ally_id: ally_id).destroy_all

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

end
