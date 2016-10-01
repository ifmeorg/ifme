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
  include LocalTimeHelper

  # Global Variables
  $per_page = 5 # For Kaminari

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Timezone
  around_filter :with_timezone

  def with_timezone
    timezone = Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:location, :name, :email, :password, :password_confirmation, :current_password, :timezone, :about, :avatar, :comment_notify, :ally_notify, :group_notify, :meeting_notify) }

    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:location, :name, :email, :password, :password_confirmation, :current_password, :timezone) }
  end

  helper_method :avatar_url, :fetch_profile_picture, :is_viewer, :are_allies, :get_uid, :most_focus, :tag_usage, :can_notify, :generate_comment, :get_stories, :moments_stats, :get_viewers_for, :viewers_hover, :created_or_edited

  def are_allies(userid1, userid2)
    userid1_allies = User.find(userid1).allies_by_status(:accepted)
    return userid1_allies.include? User.find(userid2)
  end

  def is_viewer(viewers)
    if (viewers.include? current_user.id)
      return true
    end

    return false
  end

  def get_uid(userid)
    uid = User.where(id: userid).first.uid
    return uid
  end

  def fetch_profile_picture(avatar, class_name)
    default = "/assets/default_ifme_avatar.png"

    if avatar
      if avatar.include?('/assets/contributors/')
        profile = avatar
      else
        img_url = avatar
        res = Net::HTTP.get_response(URI.parse(img_url))
        img_url = default unless res.code.to_f >= 200 && res.code.to_f < 400
        profile = img_url
      end
    else
      profile = default
    end

    result = "<div class='" + class_name.to_s + "' style='background: url(" + profile + ")'></div>"

    return result.html_safe
  end

  def most_focus(data_type, profile)
    data = Array.new

    if profile.blank?
      userid = current_user.id
    else
      userid = profile
    end

    if data_type == 'category'
      Moment.where(userid: userid).all.each do |moment|
        if !moment.category.blank? && moment.category.length > 0 && (profile.blank? || (!profile.blank? && (current_user.id == profile || moment.viewers.include?(current_user.id))))
          data += moment.category
        end
      end
      Strategy.where(userid: userid).all.each do |strategy|
        if !strategy.category.blank? && strategy.category.length > 0 && (profile.blank? || (!profile.blank? && (current_user.id == profile || strategy.viewers.include?(current_user.id))))
          data += strategy.category
        end
      end
    elsif data_type == 'mood'
      Moment.where(userid: userid).all.each do |moment|
        if !moment.mood.blank? && moment.mood.length > 0 && (profile.blank? || (!profile.blank? && (current_user.id == profile || moment.viewers.include?(current_user.id))))
          data += moment.mood
        end
      end
    elsif data_type == 'strategy'
      Moment.where(userid: userid).all.each do |moment|
        if !moment.strategies.blank? && moment.strategies.length > 0 && (profile.blank? || (!profile.blank? && (current_user.id == profile || moment.viewers.include?(current_user.id))))
          data += moment.strategies
        end
      end
    end

    # Determine top three occurrences
    result = Hash.new

    if data.length > 0
      freq = Hash.new
      for i in 0..2
        freq = data.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
          if freq.length == 0
            break
          end

          max = data.max_by { |v| freq[v] }
          if freq[max] == 0
            break
          end

          result[max] = freq[max]
        freq.delete(max)
        data.delete(max)
      end
    end

    return result
  end

  def tag_usage(data, data_type, userid)
    result = Array.new
    if (data_type == 'category')
      moments = Array.new
      Moment.where(userid: userid).order("created_at DESC").all.each do |moment|
        if !moment.category.blank? && moment.category.length > 0 && moment.category.include?(data.to_i)
          moments.push(moment.id)
        end
      end
      result.push(moments)

      strategies = Array.new
      Strategy.where(userid: userid).order("created_at DESC").all.each do |strategy|
        if !strategy.category.blank? && strategy.category.length > 0 && strategy.category.include?(data.to_i)
          strategies.push(strategy.id)
        end
      end
      result.push(strategies)
    elsif (data_type == 'mood')
      Moment.where(userid: userid).order("created_at DESC").all.each do |moment|
        if !moment.mood.blank? && moment.mood.length > 0 && moment.mood.include?(data.to_i)
          result.push(moment.id)
        end
      end
    elsif (data_type == 'strategy')
      Moment.where(userid: userid).order("created_at DESC").all.each do |moment|
        if !moment.strategies.blank? && moment.strategies.length > 0 && moment.strategies.include?(data.to_i)
          result.push(moment.id)
        end
      end
    end

    return result
  end

  def generate_comment(data, data_type)
    profile = User.where(:id => data.comment_by).first
    profile_picture = fetch_profile_picture(profile.avatar.url, 'mini_profile_picture')

    comment_info = link_to profile.name, profile_index_path(uid: get_uid(data.comment_by))
    if !are_allies(current_user.id, data.comment_by) && current_user.id != data.comment_by
      comment_info += ' ' + t('shared.comments.not_allies')
    end
    comment_info += ' - '
    comment_info += local_time_ago(data.created_at)

    comment_text = raw(data.comment)

    if data_type == 'moment'
      moment_user = Moment.where(id: data.commented_on).first.userid
      if data.visibility == 'private' && (data.comment_by == current_user.id || current_user.id == moment_user || (!data.viewers.blank? && data.viewers.include?(current_user.id)))
        visibility = '<div class="subtle">'

        if User.where(id: data.viewers[0]).exists? && Moment.where(id: data.commented_on).first.userid == current_user.id
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: data.viewers[0]).first.name
        elsif Moment.where(id: data.commented_on).first.userid == current_user.id
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: data.comment_by).first.name
        else
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: Moment.where(id: data.commented_on).first.userid).first.name
        end

        visibility += '</div>'
      end
    elsif data_type == 'strategy'
      strategy_user = Strategy.where(id: data.commented_on).first.userid
      if data.visibility == 'private' && (data.comment_by == current_user.id || current_user.id == strategy_user || (!data.viewers.blank? && data.viewers.include?(current_user.id)))
        visibility = '<div class="subtle">'

        if User.where(id: data.viewers[0]).exists? && Strategy.where(id: data.commented_on).first.userid == current_user.id
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: data.viewers[0]).first.name
        elsif Strategy.where(id: data.commented_on).first.userid == current_user.id
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: data.comment_by).first.name
        else
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: Strategy.where(id: data.commented_on).first.userid).first.name
        end

        visibility += '</div>'
      end
    end

    if (data_type == 'moment' && (Moment.where(id: data.commented_on, userid: current_user.id).exists? || data.comment_by == current_user.id)) || (data_type == 'strategy' && (Strategy.where(id: data.commented_on, userid: current_user.id).exists? || data.comment_by == current_user.id)) || (data_type == 'meeting' && (MeetingMember.where(meetingid: data.commented_on, userid: current_user.id, leader: true).exists? || data.comment_by == current_user.id))
      delete_comment = '<div class="table_cell delete_comment">'
      delete_comment += link_to raw('<i class="fa fa-times"></i>'), '', id: 'delete_comment_' + data.id.to_s, class: 'delete_comment_button'
      delete_comment += '</div>'
    end

    result = { commentid: data.id, profile_picture: profile_picture, comment_info: comment_info, comment_text: comment_text, visibility: visibility, delete_comment: delete_comment, no_save: false }

    return result
  end

  def get_stories(user, include_allies)
    if user.id == current_user.id
      my_moments = Moment.where(userid: user.id).all.order("created_at DESC")
      my_strategies = Strategy.where(userid: user.id).all.order("created_at DESC")
    end

    if include_allies && user.id == current_user.id
      allies = user.allies_by_status(:accepted)
      ally_moments = []
      ally_strategies = []

      allies.each do |ally|
        Moment.where(userid: ally.id).all.order("created_at DESC").each do |moment|
          if moment.viewers.include?(user.id)
            ally_moments << moment
          end
        end

        Strategy.where(userid: ally.id).all.order("created_at DESC").each do |strategy|
          if strategy.viewers.include?(user.id)
            ally_strategies << strategy
          end
        end
      end

      my_moments += ally_moments
      my_strategies += ally_strategies
    elsif !include_allies && user.id != current_user.id
      ally_moments = []
      ally_strategies = []

      Moment.where(userid: user.id).all.order("created_at DESC").each do |moment|
        if moment.viewers.include?(current_user.id)
          ally_moments << moment
        end
      end

      Strategy.where(userid: user.id).all.order("created_at DESC").each do |strategy|
        if strategy.viewers.include?(current_user.id)
          ally_strategies << strategy
        end
      end

      my_moments = ally_moments
      my_strategies = ally_strategies
    end

    moments = Moment.where(id: my_moments.map(&:id)).all.order("created_at DESC")
    strategies = Strategy.where(id: my_strategies.map(&:id)).all.order("created_at DESC")

    if moments.count > 0
      stories = moments.zip(strategies).flatten.compact
    else
      stories = strategies.flatten.compact
    end

    stories = stories.sort_by {|x| x.created_at }.reverse!

    return stories
  end

  def moments_stats
    result = ''
    count = Moment.where(userid: current_user.id).all.count

    if count > 1
      result += '<div class="center" id="stats">'

      if count == 1
        result += t('stats.total_moment', {count: count.to_s})
      else
        result += t('stats.total_moments', {count: count.to_s})

        monthly_count = Moment.where(userid: current_user.id, created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).all.count
        if count != monthly_count
          result += ' '
          if monthly_count == 1
            result += t('stats.monthly_moment', {count: monthly_count.to_s})
          else
            result += t('stats.monthly_moments', {count: monthly_count.to_s})
          end
        end
      end

      result += '</div>'
    end

    return result
  end

  def get_viewers_for(data, data_type)
    result = Array.new

    if data && (data_type == 'category' || data_type == 'mood' || data_type == 'strategy')
      Moment.where(userid: data.userid).all.order("created_at DESC").each do |moment|
        if data_type == 'category'
          item = moment.category
        elsif data_type == 'mood'
          item = moment.mood
        else
          item = moment.strategies
        end

        if item.include?(data.id)
          result += moment.viewers
        end
      end

      if (data_type == 'category')
        Strategy.where(userid: data.userid).all.order("created_at DESC").each do |strategy|
          if strategy.category.include?(data.id)
            result += strategy.viewers
          end
        end
      end
    end

    return result.uniq
  end

  def viewers_hover(data, link)
    result = ''
    viewers = ''

    if link
      viewers += t('shared.viewers_hover.visible_to')
    end

    if data.blank? || data.length == 0
      if link
        viewers += t('shared.viewers_hover.only_you').downcase
      else
        viewers += t('shared.viewers_hover.only_you')
      end
    end

    data.to_a.each do |viewer|
      if data.last == viewer && data.length > 1 &&  data.length == 2
        viewers += " #{t('and')} "
      elsif data.last == viewer && data.length > 1 &&  data.length != 2
        viewers += ", #{t('and')} "
      elsif data.last != viewer && data.length != 2 && viewer != data.first
        viewers += ', '
      end

      viewers += User.where(id: viewer).first.name
    end

    if link
      if link.class.name == 'Category'
        link_url = '/categories/' + link.id.to_s
      elsif link.class.name == 'Mood'
        link_url = '/moods/' + link.id.to_s
      elsif link.class.name == 'Strategy'
        link_url = '/strategies/' + link.id.to_s
      end

      result += '<span class="yes_title" title="' + viewers + '">'
      result += link_to link.name, link_url
      result += '</span>'
    else
      result += '<span class="yes_title small_margin_right" title="' + viewers + '"><i class="fa fa-lock"></i></span>'
    end

    return result.html_safe
  end

  def created_or_edited(data)
    if data.created_at != data.updated_at && local_time_ago(data.created_at) == local_time_ago(data.updated_at)
      return t('edited', {created_at: local_time_ago(data.created_at)}).html_safe
    elsif data.created_at != data.updated_at && local_time_ago(data.created_at) != local_time_ago(data.updated_at)
      return t('edited_updated_at', {created_at: local_time_ago(data.created_at), updated_at: local_time_ago(data.updated_at)}).html_safe
    end

    return t('created', {created_at: local_time_ago(data.created_at)}).html_safe
  end
end
