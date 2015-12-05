class AlliesController < ApplicationController
  before_filter :if_not_signed_in

  # GET /allies
  # GET /allies.json
  def index
    @page_search = true
    @accepted_allies = get_accepted_allies(current_user.id)
    @incoming_ally_requests = get_incoming_ally_requests(current_user.id)
    @outgoing_ally_requests = get_outgoing_ally_requests(current_user.id)
    @page_title = "Allies"
  end

  def add
    params[:userid1] = params[:userid1].to_i
    params[:userid2] = params[:userid2].to_i
    params[:status] = params[:status].to_i

    # We will enforce that :userid1 < :userid2 for convenience
    if params[:userid1] > params[:userid2]
      tmp = params[:userid1]
      params[:userid1] = params[:userid2]
      params[:userid2] = tmp
      if params[:status] == AllyStatus::PENDING_FROM_USERID1
        params[:status] = AllyStatus::PENDING_FROM_USERID2
      elsif params[:status] == AllyStatus::PENDING_FROM_USERID2
        params[:status] = AllyStatus::PENDING_FROM_USERID1
      end
    end

    if Allyship.where(user_id: params[:userid1], ally_id: params[:userid2]).exists?
      the_ally = Allyship.find_by(user_id: params[:userid1], ally_id: params[:userid2])

      # If the new status is pending_from_useridA and the old status is pending_from_useridB, where A != B, then the new status is accepted.
      if (the_ally.status == AllyStatus::PENDING_FROM_USERID1 && params[:status] == AllyStatus::PENDING_FROM_USERID2) || (the_ally.status == AllyStatus::PENDING_FROM_USERID2 && params[:status] == AllyStatus::PENDING_FROM_USERID1)
        the_ally.update(status: AllyStatus::ACCEPTED)
      else
        the_ally.update(status: params[:status])
      end
    else
       Allyship.create(user_id: params[:userid1], ally_id: params[:userid2], status: params[:status])
    end

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
