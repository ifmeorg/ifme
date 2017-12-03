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
      { name: t('languages.nl'), locale: :nl },
      { name: t('languages.ptbr'), locale: :ptbr },
      { name: t('languages.sv'), locale: :sv },
      { name: t('languages.it'), locale: :it },
      { name: t('languages.nb'), locale: :nb }
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

  def most_focus(data_type, profile_id)
    data = []
    userid = profile_id || current_user.id
    moments =
      if current_user.id == profile_id
        user_moments(userid)
      else
        user_moments(userid).where.not(published_at: nil)
      end
    if data_type == 'category'
      strategies = user_strategies(userid)
      [moments, strategies].each do |records|
        records.where(userid: userid).find_each do |r|
          if r.category.any? && (profile_id.blank? ||
                                 profile_exists?(profile_id, r))
            data += r.category
          end
        end
      end
    elsif data_type.in?(%w[mood strategy])
      moments.find_each do |m|
        data_obj = m[data_type]
        if data_obj.any? && (profile_id.blank? ||
                             profile_exists?(profile_id, m))
          data += data_obj
        end
      end
    end

    data.empty? ? {} : top_three_focus(data)
  end

  def tag_usage(data_id, data_type, userid)
    result = []
    moments = user_moments(userid).order('created_at DESC')
    if data_type == 'category'
      strategies = user_strategies(userid).order('created_at DESC')
      [moments, strategies].each do |records|
        objs = []
        records.find_each do |r|
          objs.push(r.id) if data_included?(data_type, data_id, r)
        end
        result << objs
      end
    elsif data_type.in?(%w[mood strategy])
      moments.find_each do |m|
        result << m.id if data_included?(data_type, data_id, m)
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
      comment_info += " #{t('shared.comments.not_allies')}"
    end

    comment_info += " - #{TimeAgo.formatted_ago(data.created_at)}"
    comment_text = raw(data.comment)

    if data_type == 'moment'
      visibility = CommentVisibility.build(data,
                                           Moment.find(data.commentable_id),
                                           current_user)
    elsif data_type == 'strategy'
      visibility = CommentVisibility.build(data,
                                           Strategy.find(data.commentable_id),
                                           current_user)
    end

    if comment_deletable?(data, data_type)
      delete_comment = '<div class="table_cell delete_comment">'
      delete_comment += link_to raw('<i class="fa fa-times"></i>'),
                                '',
                                id: "delete_comment_#{data.id}",
                                class: 'delete_comment_button'
      delete_comment += '</div>'
    end

    { commentid: data.id, profile_picture: profile_picture, comment_info: comment_info, comment_text: comment_text, visibility: visibility, delete_comment: delete_comment, no_save: false }
  end

  def get_stories(user, include_allies)
    if user.id == current_user.id
      my_moments = Moment.where(userid: user.id).all.recent
      my_strategies = Strategy.where(userid: user.id).all.recent
    end

    if include_allies && user.id == current_user.id
      allies = user.allies_by_status(:accepted)
      allies.each do |ally|
        my_moments += user_stories(ally, 'moments')
        my_strategies += user_stories(ally, 'strategies')
      end
    elsif !include_allies && user.id != current_user.id
      my_moments = user_stories(user, 'moments')
      my_strategies = user_stories(user, 'strategies')
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

  def data_included?(data_type, data_id, data)
    return false unless data_type.in?(%w[category mood strategy])
    data_id.in?(data[data_type])
  end

  def top_three_focus(data)
    result, freq = {}
    3.times do
      freq = data.each_with_object(Hash.new(0)) { |v, h| h[v] += 1 }
      break if freq.empty?
      max = data.max_by { |v| freq[v] }
      break if freq[max].zero?
      result[max] = freq[max]
      freq.delete(max)
      data.delete(max)
    end
    result
  end

  def profile_exists?(profile, data)
    profile.present? &&
      (current_user.id == profile ||
       data.viewers.include?(current_user.id))
  end

  def user_created_data?(id, data_type)
    case data_type
    when 'moment'
      Moment.where(id: id, userid: current_user.id).exists?
    when 'strategy'
      Strategy.where(id: id, userid: current_user.id).exists?
    when 'meeting'
      MeetingMember.where(meetingid: id, leader: true,
                          userid: current_user.id).exists?
    else
      false
    end
  end

  def comment_deletable?(data, data_type)
    data.comment_by == current_user.id ||
      user_created_data?(data.commentable_id, data_type)
  end

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
    if current_user.id == subject.userid
      @page_edit = send("edit_#{model_name}_path", subject)
      @page_tooltip = t("#{model_name.pluralize}.edit_#{model_name}")
    else
      ally = User.find(subject.userid)
      @page_author = link_to(ally.name,
                             profile_index_path(uid: get_uid(ally.id)))
    end
    @no_hide_page = true
    if subject.comment
      @comment = Comment.new
      @comments = Comment.where(
        commentable_id: subject.id,
        commentable_type: model_name
      ).order(created_at: :desc)
    end
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
    (!current_user.mutual_allies?(subject.user) \
    && !subject.viewer?(current_user)) \
    || !subject.published?
  end

  def user_strategies(userid)
    Strategy.where(userid: userid)
  end

  def user_moments(userid)
    Moment.where(userid: userid)
  end

  def user_stories(user, collection)
    resources = []
    case collection
    when 'moments'
      query = Moment.published
    when 'strategies'
      query = Strategy.published
    end

    query.where(userid: user.id).all.recent.each do |story|
      resources << story if story.viewers.include?(current_user.id)
    end
    resources
  end
end
