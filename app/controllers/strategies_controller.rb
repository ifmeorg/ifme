class StrategiesController < ApplicationController
  include CollectionPageSetup
  include ReminderHelper
  before_action :set_strategy, only: [:show, :edit, :update, :destroy]

  def index
    page_collection('@strategies', 'strategy')
  end

  def show
    if current_user.id == @strategy.userid
      @page_edit = edit_strategy_path(@strategy)
      @page_tooltip = t('strategies.edit_strategy')
    else
      link_url = '/profile?uid=' + get_uid(@strategy.userid).to_s
      the_link = link_to User.where(id: @strategy.userid).first.name, link_url
      @page_author = the_link.html_safe
    end

    @no_hide_page = false
    if hide_page && @strategy.userid != current_user.id
      respond_to do |format|
        format.html { redirect_to strategies_path }
        format.json { head :no_content }
      end
    else
      @comment = Comment.new
      @comments = Comment.where(commented_on: @strategy.id, comment_type: 'strategy').order(created_at: :desc)
      @no_hide_page = true
    end
  end

  def comment
    parameters = {
      comment_type: params[:comment_type], commented_on: params[:commented_on],
      comment_by: params[:comment_by], comment: params[:comment]
    }

    if params[:viewers].blank?
      parameters[:visibility] = params[:visibility]
    else
      parameters[:visibility] = 'private'
      parameters[:viewers] = [params[:viewers].to_i]
    end

    @comment = Comment.new(parameters)

    unless @comment.save
      result = { no_save: true }

      respond_to do |format|
        format.html { render json: result }
        format.json { render json: result }
      end
    end

    # Notify commented_on user that they have a new comment
    strategy_user = Strategy.where(id: @comment.commented_on).first.userid

    if strategy_user != @comment.comment_by
      strategy_name = Strategy.where(id: @comment.commented_on).first.name
      cutoff = @comment.comment.length > 80
      uniqueid = "comment_on_strategy_#{@comment.id}"

      data = JSON.generate(user: current_user.name,
                           strategyid: @comment.commented_on,
                           strategy: strategy_name,
                           commentid: @comment.id,
                           comment: @comment.comment[0..80],
                           cutoff: cutoff,
                           type: 'comment_on_strategy',
                           uniqueid: uniqueid)

      Notification.create(userid: strategy_user, uniqueid: uniqueid, data: data)
      notifications = Notification.where(userid: strategy_user).order('created_at ASC').all
      Pusher['private-' + strategy_user.to_s].trigger('new_notification', notifications: notifications)

      NotificationMailer.notification_email(strategy_user, data).deliver_now

      # Notify viewer that they have a new comment
    elsif !@comment.viewers.blank? && User.where(id: @comment.viewers[0]).exists?
      private_user = User.where(id: @comment.viewers[0]).first.id
      strategy_name = Strategy.where(id: @comment.commented_on).first.name
      cutoff = false
      cutoff = true if @comment.comment.length > 80
      uniqueid = 'comment_on_strategy_private' + '_' + @comment.id.to_s

      data = JSON.generate(user: current_user.name,
                           strategyid: @comment.commented_on,
                           strategy: strategy_name,
                           commentid: @comment.id,
                           comment: @comment.comment[0..80],
                           cutoff: cutoff,
                           type: 'comment_on_strategy_private',
                           uniqueid: uniqueid)

      Notification.create(userid: private_user, uniqueid: uniqueid, data: data)
      notifications = Notification.where(userid: private_user).order('created_at ASC').all
      Pusher['private-' + private_user.to_s].trigger('new_notification', notifications: notifications)

      NotificationMailer.notification_email(private_user, data).deliver_now
    end

    if @comment.save
      generate_comment(@comment, 'strategy')

      respond_to do |format|
        format.html { render json: result }
        format.json { render json: result }
      end
    end
  end

  def delete_comment
    comment_exists = Comment.find_by_id(params[:commentid])
    is_my_comment = comment_exists.comment_by == current_user.id

    if comment_exists
      strategyid = comment_exists.commented_on
      is_my_strategy = Strategy.exists?(id: strategyid, userid: current_user.id)
    else
      is_my_strategy = false
    end

    if comment_exists && (is_my_comment || is_my_strategy)
      Comment.find(params[:commentid]).destroy

      public_id = "comment_on_strategy_#{params[:commentid]}"
      private_id = "comment_on_strategy_private_#{params[:commentid]}"

      Notification.where(uniqueid: [private_id, public_id]).destroy_all
    end

    render nothing: true
  end

  def quick_create
    # Assume all viewers and comments allowed
    str = params[:strategy]

    viewers = []
    current_user.allies_by_status(:accepted).each do |item|
      viewers.push(item.id)
    end

    strategy = current_user.strategies.build(comment: true, viewers: viewers,
                                             name: str[:name],
                                             description: str[:description],
                                             category: str[:category])

    if strategy.save
      checkbox = '<input type="checkbox" value="' + strategy.id.to_s + '" name="moment[strategies][]" id="moment_strategies_' + strategy.id.to_s + '">'
      label = '<span class="notification_wrapper">
            <span class="tip_notifications_button link_style">' + strategy.name + '</span><br>'
      label += render_to_string partial: '/notifications/preview', locals: { data: strategy, edit: edit_strategy_path(strategy) }
      label += '</span>'
      result = { checkbox: checkbox, label: label }
    else
      result = { error: 'error' }
    end

    respond_to do |format|
      format.html { render json: result }
      format.json { render json: result }
    end
  end

  def new
    @viewers = current_user.allies_by_status(:accepted)
    @strategy = Strategy.new
    @categories = current_user.categories.order(created_at: :desc)
    @category = Category.new
    @strategy.build_perform_strategy_reminder
  end

  def edit
    if @strategy.userid == current_user.id
      @viewers = current_user.allies_by_status(:accepted)
      @categories = current_user.categories.order(created_at: :desc)
      @category = Category.new
      PerformStrategyReminder.find_or_initialize_by(strategy_id: @strategy.id)
    else
      respond_to do |format|
        format.html { redirect_to strategy_path(@strategy) }
        format.json { head :no_content }
      end
    end
  end

  def create
    @strategy = Strategy.new(strategy_params)
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new
    respond_to do |format|
      if @strategy.save
        format.html { redirect_to strategy_path(@strategy) }
        format.json { render :show, status: :created, location: @strategy }
      else
        format.html { render :new }
        format.json { render json: @strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  def premade
    premade_category = current_user.categories.find_by(name: 'Meditation')

    params = { name: t('strategies.index.premade1_name'), comment: false,
               description: t('strategies.index.premade1_description') }
    params.merge category: [premade_category.id] if premade_category.present?

    current_user.strategies.create(params)

    respond_to do |format|
      format.html { redirect_to strategies_path }
      format.json { render :no_content }
    end
  end

  def update
    @viewers = current_user.allies_by_status(:accepted)
    @category = Category.new

    respond_to do |format|
      if @strategy.update(strategy_params)
        format.html { redirect_to strategy_path(@strategy) }
        format.json { render :show, status: :ok, location: @strategy }
      else
        format.html { render :edit }
        format.json { render json: @strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_user.moments.each do |moment|
      moment.strategies.delete(@strategy.id)
      moment.save!
    end

    @strategy.destroy

    respond_to do |format|
      format.html { redirect_to strategies_path }
      format.json { head :no_content }
    end
  end

  private

  def set_strategy
    @strategy = Strategy.find(params[:id])
  rescue
    if @strategy.blank?
      respond_to do |format|
        format.html { redirect_to strategies_path }
        format.json { head :no_content }
      end
    end
  end

  def default_params
    @default_params ||= { strategy: { viewers: [], category: [] } }
  end

  def strategy_params
    params[:strategy] = default_params[:strategy].merge(params[:strategy])

    params.require(:strategy)
          .permit(:name, :description, :userid, :comment,
                  category: [], viewers: [],
                  perform_strategy_reminder_attributes: [:active, :id])
  end

  def hide_page
    return false if @strategy.viewers.include?(current_user.id) &&
                    are_allies(@strategy.userid, current_user.id)

    true
  end
end
