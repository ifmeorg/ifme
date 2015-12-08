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
    Allyship.create(user_id: current_user.id, ally_id: params[:ally_id], status: User.ALLY_STATUS[:accepted])

    respond_to do |format|
      format.html { redirect_to allies_path }
      format.json { head :no_content }
    end
  end

  def remove
    params[:userid1] = params[:userid1].to_i
    params[:userid2] = params[:userid2].to_i

    # We will enforce that :userid1 < :userid2 for convenience
    if params[:userid1] > params[:userid2]
      tmp = params[:userid1]
      params[:userid1] = params[:userid2]
      params[:userid2] = tmp.to_i
    end

    the_ally = Allyship.find_by(user_id: params[:userid1], ally_id: params[:userid2])

    the_ally.destroy

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
