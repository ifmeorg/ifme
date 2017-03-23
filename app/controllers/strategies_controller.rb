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
      link_url = "/profile?uid=" + get_uid(@strategy.userid).to_s
      name = User.where(id: @strategy.userid).first.name
      the_link = sanitize link_to name, link_url
      @page_author = the_link.html_safe
    end

    @no_hide_page = false
    if hide_page && @strategy.userid != current_user.id
      respond_to do |format|
        format.html { redirect_to strategies_path }
        format.json { head :no_content }
      end
    else
      @comments = Comment.where(commented_on: @strategy.id, comment_type: 'strategy').order(created_at: :desc)
      @no_hide_page = true
    end
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
    premade_category = Category.where(name: 'Meditation', userid: current_user.id)
    if premade_category.exists?
      premade1 = Strategy.new(
        userid: current_user.id,
        name: t('strategies.index.premade1_name'),
        description: t('strategies.index.premade1_description'),
        category: [premade_category.first.id], comment: false
      )
    else
      premade1 = Strategy.new(
        userid: current_user.id,
        name: t('strategies.index.premade1_name'),
        description: t('strategies.index.premade1_description'),
        comment: false
      )
    end

    respond_to do |format|
      if premade1.save
        PerformStrategyReminder.create(strategy_id: premade1.id, active: false)
        format.html { redirect_to strategies_path }
        format.json { render :no_content }
      else
        format.html { redirect_to strategies_path }
        format.json do
          render json: premade1.errors, status: :unprocessable_entity
        end
      end
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
    @strategy = Strategy.friendly.find(params[:id])
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
