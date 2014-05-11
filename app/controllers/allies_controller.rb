class AlliesController < ApplicationController
  before_filter :if_not_signed_in
  # GET /allies
  # GET /allies.json
  def index
    @page_search = true
    @ally_requests = Array.new
    Ally.where.not(:userid => current_user.id).all.each do |item|
      if item.allies.include?(current_user.id.to_s) && (!Ally.where(:userid => current_user.id).exists? || !Ally.where(:userid => current_user.id).first.allies.include?(item.userid.to_s))
        @ally_requests.push(item.userid)
      end  
    end
    @allies = Ally.where(:userid => current_user.id).all
    @page_title = "Allies"
  end

  def add
    if Ally.where(:userid => current_user.id).exists?
      the_allies = Ally.where(:userid => current_user.id).first.allies

      if !the_allies.include?(params[:userid].to_s) 
        the_allies.push(params[:userid])
      end 

      the_user = Ally.find_by(userid: current_user.id)
      the_user.update(allies: the_allies)
    else 
      new_ally = [params[:userid]]
      Ally.create(userid: current_user.id, allies: new_ally)
    end

    respond_to do |format|
      format.html { redirect_to allies_path }
      format.json { head :no_content }
    end
  end

  def remove
    update_allies = Ally.where(:userid => current_user.id).first.allies 
    update_allies.delete(params[:userid].to_s)
    the_user = Ally.find_by(:userid => current_user.id)
    the_user.update(allies: update_allies)

    if Ally.where(:userid => params[:userid]).exists? && Ally.where(:userid => params[:userid]).first.allies.include?(current_user.id.to_s)
      update_allies2 = Ally.where(:userid => params[:userid]).first.allies 
      update_allies2.delete(current_user.id.to_s)
      the_user2 = Ally.find_by(:userid => params[:userid])
      the_user2.update(allies: update_allies2)
    end

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
