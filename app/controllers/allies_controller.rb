class AlliesController < ApplicationController
  before_filter :if_not_signed_in

  # GET /allies
  # GET /allies.json
  def index
    @page_search = true
    @accepted_allies = current_user.allies_by_status(:accepted)
    @incoming_ally_requests = current_user.allies_by_status(:pending_from_user)
    @outgoing_ally_requests = current_user.allies_by_status(:pending_from_ally)
    @page_title = "Allies"
  end

  def add
    allyship = Allyship.find_by(user_id: current_user.id, ally_id: params[:ally_id])

    if allyship
      allyship.update(status: User::ALLY_STATUS[:accepted])
    else
      Allyship.create(
        user_id: current_user.id,
        ally_id: params[:ally_id],
        status: User::ALLY_STATUS[:pending_from_ally]
      )
    end
    
    respond_to do |format|
      format.html { redirect_to allies_path }
      format.json { head :no_content }
    end
  end

  def remove
    Allyship.find_by(user_id: current_user.id, ally_id: params[:ally_id]).destroy

    respond_to do |format|
      format.html { redirect_to allies_path }
      format.json { head :no_content }
    end
  end

  private

  def if_not_signed_in
    if !user_signed_in?
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.json { head :no_content }
      end
    end
  end
end
