class MomentsController < ApplicationController
  before_filter :if_not_signed_in
  before_action :set_moment, only: [:show, :edit, :update, :destroy]

  # GET /moments
  # GET /moments.json
  def index
    @moments = Moment.where(:userid => current_user.id).all.order("created_at DESC").page(params[:page]).per($per_page)
    @page_title = "Moments"
    @page_new = new_moment_path
    @page_tooltip = "New moment"
  end

  # GET /moments/1
  # GET /moments/1.json
  def show
    if current_user.id == @moment.userid
      @page_edit = edit_moment_path(@moment)
      @page_tooltip = "Edit moment"
    else
      link_url = "/profile?userid=" + @moment.userid.to_s
      the_link = link_to User.where(:id => @moment.userid).first.name, link_url
      @page_author = the_link.html_safe
    end
    @no_hide_page = false
    if hide_page(@moment) && @moment.userid != current_user.id
      respond_to do |format|
        format.html { redirect_to moments_path }
        format.json { head :no_content }
      end
    else
      @comment = Comment.new
      # @support = Support.new
      @comments = Comment.where(:commented_on => @moment.id, :comment_type => 'moment').all.order("created_at DESC")
      @no_hide_page = true
      @page_title = @moment.name
    end
  end

  def comment
    if params[:viewers].blank?
      @comment = Comment.new(:comment_type => params[:comment_type], :commented_on => params[:commented_on], :comment_by => params[:comment_by], :comment => params[:comment], :visibility => params[:visibility])
    else
      # Can only get here if comment is from Moment creator
      @comment = Comment.new(:comment_type => params[:comment_type], :commented_on => params[:commented_on], :comment_by => params[:comment_by], :comment => params[:comment], :visibility => 'private', :viewers => [params[:viewers].to_i])
    end

    if !@comment.save
      result = { no_save: true }
      respond_to do |format|
        format.html { render json: result }
        format.json { render json: result }
      end
    end

    # Notify commented_on user that they have a new comment
    moment_user = Moment.where(id: @comment.commented_on).first.userid

    if (moment_user != @comment.comment_by)
      moment_name = Moment.where(id: @comment.commented_on).first.name
      cutoff = false
      if @comment.comment.length > 80
        cutoff = true
      end
      uniqueid = 'comment_on_moment' + '_' + @comment.id.to_s

      data = JSON.generate({
        user: current_user.name,
        momentid: @comment.commented_on,
        moment: moment_name,
        commentid: @comment.id,
        comment: @comment.comment[0..80],
        cutoff: cutoff,
        type: 'comment_on_moment',
        uniqueid: uniqueid
        })

      Notification.create(userid: moment_user, uniqueid: uniqueid, data: data)
      notifications = Notification.where(userid: moment_user).order("created_at ASC").all
      Pusher['private-' + moment_user.to_s].trigger('new_notification', {notifications: notifications})

      NotificationMailer.notification_email(moment_user, data).deliver_now

    # Notify viewer that they have a new comment
    elsif !@comment.viewers.blank? && User.where(id: @comment.viewers[0]).exists?
      private_user = User.where(id: @comment.viewers[0]).first.id
      moment_name = Moment.where(id: @comment.commented_on).first.name
      cutoff = false
      if @comment.comment.length > 80
        cutoff = true
      end
      uniqueid = 'comment_on_moment_private' + '_' + @comment.id.to_s

      data = JSON.generate({
        user: current_user.name,
        momentid: @comment.commented_on,
        moment: moment_name,
        commentid: @comment.id,
        comment: @comment.comment[0..80],
        cutoff: cutoff,
        type: 'comment_on_moment_private',
        uniqueid: uniqueid
        })

      Notification.create(userid: private_user, uniqueid: uniqueid, data: data)
      notifications = Notification.where(userid: private_user).order("created_at ASC").all
      Pusher['private-' + private_user.to_s].trigger('new_notification', {notifications: notifications})

      NotificationMailer.notification_email(private_user, data).deliver_now
    end

    if @comment.save
      result = generate_comment(@comment, 'moment')
      respond_to do |format|
        format.html { render json: result }
        format.json { render json: result }
      end
    end
  end

  def delete_comment
    comment_exists = Comment.where(id: params[:commentid]).exists?
    is_my_comment = Comment.where(id: params[:commentid], comment_by: current_user.id).exists?

    if comment_exists
      momentid = Comment.where(id: params[:commentid]).first.commented_on
      is_my_moment = Moment.where(id: momentid, userid: current_user.id).exists?
      is_a_viewer = is_viewer(Moment.where(id: momentid).first.viewers)
    else
      is_my_moment = false
      is_a_viewer = false
    end

    if comment_exists && ((is_my_comment && is_a_viewer) || is_my_moment)
      Comment.find(params[:commentid]).destroy

      # Delete corresponding notifcations
      public_uniqueid = 'comment_on_moment_' + params[:commentid].to_s
      Notification.where(uniqueid: public_uniqueid).destroy_all

      private_uniqueid = 'comment_on_moment_private_' + params[:commentid].to_s
      Notification.where(uniqueid: private_uniqueid).destroy_all
    end

    render :nothing => true
  end

  def quick_moment
    # Assumme all viewers and comments allowed
    viewers = Array.new
    current_user.allies_by_status(:accepted).each do |item|
      viewers.push(item.id)
    end

    moment = Moment.new(userid: current_user.id, name: params[:moment][:name], why: params[:moment][:why], comment: true, viewers: viewers, category: params[:moment][:category], mood: params[:moment][:mood])
    moment.save

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render root_path }
    end
  end

  # def support
  #   if !params[:support].nil? && !params[:support][:userid].empty? && !params[:support][:support_type].empty? && !params[:support][:support_id].empty?
  #     params[:userid] = params[:support][:userid]
  #     params[:support_type] = params[:support][:support_type]
  #     params[:support_id] = params[:support][:support_id]
  #   end

  #   support_id = params[:support_id].to_i

  #   if Support.where(userid: params[:userid], support_type: params[:support_type]).exists?
  #     new_support_ids = Support.where(userid: params[:userid], support_type: params[:support_type]).first.support_ids
  #     if new_support_ids.include?(support_id)
  #       new_support_ids.delete(support_id)
  #       the_support = Support.find_by(userid: params[:userid], support_type: params[:support_type])
  #       if new_support_ids.empty?
  #         @support = the_support.destroy
  #       else
  #         @support = the_support.update!(support_ids: new_support_ids)
  #       end
  #     else
  #       new_support_ids = new_support_ids.push(support_id)
  #       the_support = Support.find_by(userid: params[:userid], support_type: params[:support_type])
  #       the_support.update!(support_ids: new_support_ids)
  #     end
  #   else
  #     @support = Support.create!(userid: params[:userid], support_type: params[:support_type], support_ids: Array.new(1, support_id))
  #   end

  #   respond_to do |format|
  #       format.html { redirect_to moment_path(support_id) }
  #       format.json { render :show, status: :created, location: Moment.find(support_id) }
  #   end
  # end

  # GET /moments/new
  def new
    @viewers = current_user.allies_by_status(:accepted)
    @categories = Category.where(:userid => current_user.id).all.order("created_at DESC")
    @moods = Mood.where(:userid => current_user.id).all.order("created_at DESC")

    # current_user's strategies and all viewable strategies from allies
    my_strategies = Strategy.where(:userid => current_user.id).all.order("created_at DESC")
    ally_strategies = []
    @viewers.each do |ally|
      Strategy.where(userid: ally.id).all.order("created_at DESC").each do |strategy|
        if strategy.viewers.include?(current_user.id)
          ally_strategies << strategy
        end
      end
    end
    my_strategies += ally_strategies
    @strategies = Strategy.where(id: my_strategies.map(&:id)).all.order("created_at DESC")

    @moment = Moment.new
    @page_title = "New Moment"
    @category = Category.new
    @mood = Mood.new
    @strategy = Strategy.new
  end

  # GET /moments/1/edit
  def edit
    if @moment.userid == current_user.id
      @viewers = current_user.allies_by_status(:accepted)
      @categories = Category.where(:userid => current_user.id).all.order("created_at DESC")
      @moods = Mood.where(:userid => current_user.id).all.order("created_at DESC")

      # current_user's strategies and all viewable strategies from allies
      my_strategies = Strategy.where(:userid => current_user.id).all.order("created_at DESC")
      ally_strategies = []
      @viewers.each do |ally|
        Strategy.where(userid: ally.id).all.order("created_at DESC").each do |strategy|
          if strategy.viewers.include?(current_user.id)
            ally_strategies << strategy
          end
        end
      end
      my_strategies += ally_strategies
      @strategies = Strategy.where(id: my_strategies.map(&:id)).all.order("created_at DESC")

      @page_title = "Edit " + @moment.name
      @category = Category.new
      @mood = Mood.new
      @strategy = Strategy.new
    else
      respond_to do |format|
        format.html { redirect_to moment_path(@moment) }
        format.json { head :no_content }
      end
    end
  end

  # POST /moments
  # POST /moments.json
  def create
    @moment = Moment.new(moment_params)
    @page_title = "New Moment"
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    @mood = Mood.new
    @strategy = Strategy.new
    respond_to do |format|
      if @moment.save
        format.html { redirect_to moment_path(@moment) }
        format.json { render :show, status: :created, location: @moment }
      else
        format.html { render :new }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moments/1
  # PATCH/PUT /moments/1.json
  def update
    @page_title = "Edit " + @moment.name
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    @mood = Mood.new
    @strategy = Strategy.new
    respond_to do |format|
      if @moment.update(moment_params)
        format.html { redirect_to moment_path(@moment) }
        format.json { render :show, status: :ok, location: @moment }
      else
        format.html { render :edit }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moments/1
  # DELETE /moments/1.json
  def destroy
    @moment.destroy
    respond_to do |format|
      format.html { redirect_to moments_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moment
      begin
        @moment = Moment.find(params[:id])
      rescue
        if @moment.blank?
          respond_to do |format|
            format.html { redirect_to moments_path }
            format.json { head :no_content }
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def moment_params
      params.require(:moment).permit(:name, :why, :fix, :userid, :comment, {:category => []}, {:mood => []}, {:viewers => []}, {:strategies => []})
    end

    def hide_page(moment)
      if Moment.where(id: moment.id).exists?
        if Moment.where(id: moment.id).first.viewers.include?(current_user.id) && are_allies(moment.userid, current_user.id)
          return false
        end
      end
      return true
    end

    def if_not_signed_in
      if !user_signed_in?
        respond_to do |format|
          format.html { redirect_to new_user_session_path }
          format.json { head :no_content }
        end
      else
      end
    end

end
