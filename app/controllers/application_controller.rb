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

  before_action :set_locale

  # Timezone
  around_action :with_timezone

  def with_timezone
    timezone = Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end

  # before_action
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def configure_permitted_parameters
    common = %i(location name email password password_confirmation
                current_password)
    updating = %i(about avatar remove_avatar comment_notify ally_notify
                  group_notify meeting_notify)

    devise_parameter_sanitizer.permit :account_update, keys: updating + common
    devise_parameter_sanitizer.permit :sign_up, keys: common
  end

  helper_method :avatar_url, :is_viewer,
                :are_allies, :get_uid, :most_focus,
                :tag_usage, :can_notify, :if_not_signed_in,
                :generate_comment, :get_stories, :moments_stats

  def if_not_signed_in
    unless user_signed_in?
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.json { head :no_content }
      end
    end
  end

  def respond_to_nothing(path = :back)
    respond_to do |format|
      format.html { redirect_to path }
      format.json { head :no_content }
    end
  end

  def are_allies(userid1, userid2)
    userid1_allies = User.find(userid1).allies_by_status(:accepted)
    userid1_allies.include? User.find(userid2)
  end

  def is_viewer(viewers)
    return true if viewers.include? current_user.id

    false
  end

  def get_uid(user_id)
    User.find_by(id: user_id).uid
  end

  def fetch_profile_picture(avatar, class_name)
    content_tag :div, nil,
                class: class_name, style: "background: url(#{avatar})"
  end

  def most_focus(data_type, profile)
    data = []

    userid = if profile.blank?
               current_user.id
             else
               profile
             end

    if data_type == 'category'
      Moment.where(userid: userid).all.each do |moment|
        if !moment.category.blank? && !moment.category.empty? && (profile.blank? || (!profile.blank? && (current_user.id == profile || moment.viewers.include?(current_user.id))))
          data += moment.category
        end
      end
      Strategy.where(userid: userid).all.each do |strategy|
        if !strategy.category.blank? && !strategy.category.empty? && (profile.blank? || (!profile.blank? && (current_user.id == profile || strategy.viewers.include?(current_user.id))))
          data += strategy.category
        end
      end
    elsif data_type == 'mood'
      Moment.where(userid: userid).all.each do |moment|
        if !moment.mood.blank? && !moment.mood.empty? && (profile.blank? || (!profile.blank? && (current_user.id == profile || moment.viewers.include?(current_user.id))))
          data += moment.mood
        end
      end
    elsif data_type == 'strategy'
      Moment.where(userid: userid).all.each do |moment|
        if !moment.strategies.blank? && !moment.strategies.empty? && (profile.blank? || (!profile.blank? && (current_user.id == profile || moment.viewers.include?(current_user.id))))
          data += moment.strategies
        end
      end
    end

    # Determine top three occurrences
    result = {}

    unless data.empty?
      freq = {}
      for i in 0..2
        freq = data.each_with_object(Hash.new(0)) { |v, h| h[v] += 1; h }
        break if freq.empty?

        max = data.max_by { |v| freq[v] }
        break if freq[max] == 0

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
        if !moment.category.blank? && !moment.category.empty? && moment.category.include?(data.to_i)
          moments.push(moment.id)
        end
      end
      result.push(moments)

      strategies = []
      Strategy.where(userid: userid).order('created_at DESC').all.each do |strategy|
        if !strategy.category.blank? && !strategy.category.empty? && strategy.category.include?(data.to_i)
          strategies.push(strategy.id)
        end
      end
      result.push(strategies)
    elsif data_type == 'mood'
      Moment.where(userid: userid).order('created_at DESC').all.each do |moment|
        if !moment.mood.blank? && !moment.mood.empty? && moment.mood.include?(data.to_i)
          result.push(moment.id)
        end
      end
    elsif data_type == 'strategy'
      Moment.where(userid: userid).order('created_at DESC').all.each do |moment|
        if !moment.strategies.blank? && !moment.strategies.empty? && moment.strategies.include?(data.to_i)
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

    comment_info = link_to profile.name, profile_index_path(uid: get_uid(data.comment_by))
    if !are_allies(current_user.id, data.comment_by) && current_user.id != data.comment_by
      comment_info += ' ' + t('shared.comments.not_allies')
    end
    comment_info += ' - '
    comment_info += TimeAgo.formatted_ago(data.created_at)

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

    if (data_type == 'moment' && (Moment.where(id: data.commented_on, userid: current_user.id).exists? || data.comment_by == current_user.id)) ||
      (data_type == 'strategy' && (Strategy.where(id: data.commented_on, userid: current_user.id).exists? || data.comment_by == current_user.id)) ||
      (data_type == 'meeting' && (MeetingMember.where(meetingid: data.commented_on, userid: current_user.id, leader: true).exists? || data.comment_by == current_user.id))
      delete_comment = '<div class="table_cell delete_comment">'
      delete_comment += link_to raw('<i class="fa fa-times"></i>'), '', id: 'delete_comment_' + data.id.to_s, class: 'delete_comment_button'
      delete_comment += '</div>'
    end

    result = { commentid: data.id, profile_picture: profile_picture, comment_info: comment_info, comment_text: comment_text, visibility: visibility, delete_comment: delete_comment, no_save: false }

    result
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

    moments = Moment.where(id: my_moments.map(&:id)).all.order('created_at DESC')
    strategies = Strategy.where(id: my_strategies.map(&:id)).all.order('created_at DESC')

    stories = if moments.count > 0
                moments.zip(strategies).flatten.compact
              else
                strategies.flatten.compact
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

  def created_or_edited(data)
    if data.created_at != data.updated_at && local_time_ago(data.created_at) == local_time_ago(data.updated_at)
      return t('edited', created_at: local_time_ago(data.created_at)).html_safe
    elsif data.created_at != data.updated_at && local_time_ago(data.created_at) != local_time_ago(data.updated_at)
      return t('edited_updated_at', created_at: local_time_ago(data.created_at), updated_at: local_time_ago(data.updated_at)).html_safe
    end

    t('created', created_at: local_time_ago(data.created_at)).html_safe
  end

  private

  def logged_in_as_owner?(owner)
    owner.id == current_user.id
  end

  def logged_in_user_made_comment?(comment)
    comment.comment_by == current_user.id
  end

  def logged_in_user_is_viewer?(comment)
    !comment.viewers.blank? && comment.viewers.include?(current_user.id)
  end

  def logged_in_user_can_view_comment?(comment, owner)
    logged_in_user_made_comment?(comment) || logged_in_as_owner?(owner) || logged_in_user_is_viewer?(comment)
  end

  def visibility_html(comment, commented_on)
    owner = User.find(commented_on.userid)

    if comment.visibility == 'private' && logged_in_user_can_view_comment?(comment, owner)
      visibility = '<div class="subtle">'

      other_person = nil

      if logged_in_as_owner?(owner)
        if viewer = User.where(id: comment.viewers[0]).first
          # you are logged in as owner, you made the comment, and it is visible to a viewer
          other_person = viewer
        else
          # you are logged in as owner, and comment was made by somebody else
          other_person = User.find(comment.comment_by)
        end
      else
        # you are logged in as comment maker, and it is visible to you and owner
        other_person = owner
      end

      visibility += t('shared.comments.visible_only_between_you_and',
                      name: other_person.name)

      visibility += '</div>'
    end
  end
end
