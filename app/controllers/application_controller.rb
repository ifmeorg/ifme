# frozen_string_literal: true

module UserRelation
  mattr_accessor :myself, :ally, :incoming_request, :outgoing_request, :other
  MYSELF = 0
  ALLY = 1
  INCOMING_REQUEST = 2
  OUTGOING_REQUEST = 3
  OTHER = 4
end

class ApplicationController < ActionController::Base
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TextHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: proc { |c| c.request.format == 'application/json' }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :if_not_signed_in, unless: :devise_controller?

  # i18n
  before_action :set_locale

  # Timezone
  around_action :with_timezone

  def with_timezone
    timezone = Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end

  # before_action
  def set_locale
    @locales = [
      { name: t('languages.en'), locale: :en },
      { name: t('languages.es'), locale: :es },
      { name: t('languages.ptbr'), locale: :ptbr }
    ].freeze
    @locale = I18n.locale = locale
  end

  def locale
    current_user&.locale || cookies[:locale] || I18n.default_locale
  end

  def configure_permitted_parameters
    common = %i[location name email password
                password_confirmation current_password]

    configure_for_account_update(common)
    configure_for_sign_up(common)
    configure_for_accept_invitation
  end

  def configure_for_account_update(common)
    devise_parameter_sanitizer.permit :account_update,
                                      keys: %i[about avatar
                                               remove_avatar comment_notify
                                               ally_notify group_notify
                                               meeting_notify] + common
  end

  def configure_for_sign_up(common)
    devise_parameter_sanitizer.permit :sign_up, keys: common
  end

  def configure_for_accept_invitation
    devise_parameter_sanitizer.permit :accept_invitation,
                                      keys: %i[name password
                                               password_confirmation
                                               invitation_token]
  end

  helper_method :avatar_url, :is_viewer,
                :are_allies?, :get_uid, :most_focus,
                :tag_usage, :can_notify, :if_not_signed_in,
                :generate_comment, :get_stories, :moments_stats

  def if_not_signed_in
    return if user_signed_in?

    respond_to do |format|
      format.html { redirect_to new_user_session_path }
      format.json { head :no_content }
    end
  end

  def are_allies?(user_id1, user_id2)
    users = User.where(id: [user_id1, user_id2])
    users.first.mutual_allies?(users.last)
  end

  def is_viewer(viewers)
    viewers.include? current_user.id
  end

  def get_uid(userid)
    User.find(userid).uid
  end

  def most_focus(data_type, profile)
    data = []

    userid =
      if profile.blank?
        current_user.id
      else
        profile
      end

    if data_type == 'category'
      Moment.where(userid: userid).all.each do |moment|
        if moment.category.present? && !moment.category.empty? && (profile.blank? || (profile.present? && (current_user.id == profile || moment.viewers.include?(current_user.id))))
          data += moment.category
        end
      end
      Strategy.where(userid: userid).all.each do |strategy|
        if strategy.category.present? && !strategy.category.empty? && (profile.blank? || (profile.present? && (current_user.id == profile || strategy.viewers.include?(current_user.id))))
          data += strategy.category
        end
      end
    elsif data_type == 'mood'
      Moment.where(userid: userid).all.each do |moment|
        if moment.mood.present? && !moment.mood.empty? && (profile.blank? || (profile.present? && (current_user.id == profile || moment.viewers.include?(current_user.id))))
          data += moment.mood
        end
      end
    elsif data_type == 'strategy'
      Moment.where(userid: userid).all.each do |moment|
        if moment.strategy.present? && !moment.strategy.empty? && (profile.blank? || (profile.present? && (current_user.id == profile || moment.viewers.include?(current_user.id))))
          data += moment.strategy
        end
      end
    end

    # Determine top three occurrences
    result = {}

    unless data.empty?
      freq = {}
      3.times do
        freq = data.each_with_object(Hash.new(0)) { |v, h| h[v] += 1 }
        break if freq.empty?

        max = data.max_by { |v| freq[v] }
        break if freq[max].zero?

        result[max] = freq[max]
        freq.delete(max)
        data.delete(max)
      end
    end

    result
  end

  def tag_usage(data, data_type, userid)
    result = []
    if data_type == 'category'
      moments = []
      Moment.where(userid: userid).order('created_at DESC').all.each do |moment|
        if moment.category.present? && !moment.category.empty? && moment.category.include?(data.to_i)
          moments.push(moment.id)
        end
      end
      result.push(moments)

      strategies = []
      Strategy.where(userid: userid).order('created_at DESC').all.each do |strategy|
        if strategy.category.present? && !strategy.category.empty? && strategy.category.include?(data.to_i)
          strategies.push(strategy.id)
        end
      end
      result.push(strategies)
    elsif data_type == 'mood'
      Moment.where(userid: userid).order('created_at DESC').all.each do |moment|
        if moment.mood.present? && !moment.mood.empty? && moment.mood.include?(data.to_i)
          result.push(moment.id)
        end
      end
    elsif data_type == 'strategy'
      Moment.where(userid: userid).order('created_at DESC').all.each do |moment|
        if moment.strategy.present? && !moment.strategy.empty? && moment.strategy.include?(data.to_i)
          result.push(moment.id)
        end
      end
    end

    result
  end

  def generate_comment(data, data_type)
    profile = User.find(data.comment_by)
    profile_picture = ProfilePicture.fetch(profile.avatar.url,
                                           'mini_profile_picture')

    comment_info = link_to(profile.name, profile_index_path(uid: profile.uid))

    if current_user != profile && !current_user.mutual_allies?(profile)
      comment_info += ' ' + t('shared.comments.not_allies')
    end

    comment_info += ' - ' + TimeAgo.formatted_ago(data.created_at)
    comment_text = raw(data.comment)

    if data_type == 'moment'
      visibility = CommentVisibility.build(data,
                                           Moment.find(data.commented_on),
                                           current_user)
    elsif data_type == 'strategy'
      visibility = CommentVisibility.build(data,
                                           Strategy.find(data.commented_on),
                                           current_user)
    end

    if (data_type == 'moment' && (Moment.where(id: data.commented_on, userid: current_user.id).exists? || data.comment_by == current_user.id)) || (data_type == 'strategy' && (Strategy.where(id: data.commented_on, userid: current_user.id).exists? || data.comment_by == current_user.id)) || (data_type == 'meeting' && (MeetingMember.where(meetingid: data.commented_on, userid: current_user.id, leader: true).exists? || data.comment_by == current_user.id))
      delete_comment = '<div class="table_cell delete_comment">'
      delete_comment += link_to raw('<i class="fa fa-times"></i>'), '', id: 'delete_comment_' + data.id.to_s, class: 'delete_comment_button'
      delete_comment += '</div>'
    end

    { commentid: data.id, profile_picture: profile_picture, comment_info: comment_info, comment_text: comment_text, visibility: visibility, delete_comment: delete_comment, no_save: false }
  end

  def get_stories(user, include_allies)
    if user.id == current_user.id
      my_moments = Moment.where(userid: user.id).all.order('created_at DESC')
      my_strategies = Strategy.where(userid: user.id).all.order('created_at DESC')
    end

    if include_allies && user.id == current_user.id
      allies = user.allies_by_status(:accepted)
      ally_moments = []
      ally_strategies = []

      allies.each do |ally|
        Moment.where(userid: ally.id).all.order('created_at DESC').each do |moment|
          ally_moments << moment if moment.viewers.include?(user.id)
        end

        Strategy.where(userid: ally.id).all.order('created_at DESC').each do |strategy|
          ally_strategies << strategy if strategy.viewers.include?(user.id)
        end
      end

      my_moments += ally_moments
      my_strategies += ally_strategies
    elsif !include_allies && user.id != current_user.id
      ally_moments = []
      ally_strategies = []

      Moment.where(userid: user.id).all.order('created_at DESC').each do |moment|
        ally_moments << moment if moment.viewers.include?(current_user.id)
      end

      Strategy.where(userid: user.id).all.order('created_at DESC').each do |strategy|
        if strategy.viewers.include?(current_user.id)
          ally_strategies << strategy
        end
      end

      my_moments = ally_moments
      my_strategies = ally_strategies
    end

    moments = Moment.where(id: my_moments.map(&:id)).order(created_at: :desc)
    strategies = Strategy.where(id: my_strategies.map(&:id))
                         .order(created_at: :desc)

    stories =
      if moments.count.positive?
        moments.zip(strategies).flatten.compact
      else
        strategies.compact
      end

    stories.sort_by(&:created_at).reverse!
  end

  def moments_stats
    result = ''
    count = Moment.where(userid: current_user.id).all.count

    if count > 1
      result += '<div class="center" id="stats">'

      if count == 1
        result += t('stats.total_moment', count: count.to_s)
      else
        result += t('stats.total_moments', count: count.to_s)

        monthly_count = Moment.where(userid: current_user.id, created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).all.count
        if count != monthly_count
          result += ' '
          if monthly_count == 1
            result += t('stats.monthly_moment', count: monthly_count.to_s)
          else
            result += t('stats.monthly_moments', count: monthly_count.to_s)
          end
        end
      end

      result += '</div>'
    end

    result
  end

  private

  def comment_for(model_name)
    @comment = Comment.create_from!(params)
    @comment.notify_of_creation!(current_user)

    respond_with_json(
      generate_comment(@comment, model_name)
    )
  rescue ActiveRecord::RecordInvalid
    respond_not_saved
  end

  def show_with_comments(subject)
    model_name = record_model_name(subject)

    if current_user.id != subject.userid && hide_page?(subject)
      path = send("#{model_name.pluralize}_path")
      return redirect_to_path(path)
    end

    set_show_with_comments_variables(subject, model_name)
  end

  def set_show_with_comments_variables(subject, model_name)
    @page_edit = send("edit_#{model_name}_path", subject)
    @page_tooltip = t("#{model_name.pluralize}.edit_#{model_name}")
    @no_hide_page = true
    @comment = Comment.new
    @comments = Comment.where(
      commented_on: subject.id,
      comment_type: model_name
    ).order(created_at: :desc)
  end

  def record_model_name(record)
    record.class.name.downcase
  end

  def redirect_to_path(path)
    respond_to do |format|
      format.html { redirect_to path }
      format.json { head :no_content }
    end
  end

  def respond_not_saved
    respond_with_json(no_save: true)
  end

  def respond_with_json(reponse)
    respond_to do |format|
      format.html { render json: reponse }
      format.json { render json: reponse }
    end
  end

  def hide_page?(subject)
    subject.viewer?(current_user) && current_user.mutual_allies?(subject.user)
  end
end
