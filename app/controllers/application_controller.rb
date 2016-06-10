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

  helper_method :fetch_taxonomies, :avatar_url, :fetch_profile_picture, :no_taxonomies_error, :is_viewer, :are_allies, :print_list_links, :get_uid, :most_focus, :tag_usage, :can_notify, :generate_comment, :get_stories, :moments_stats, :get_viewers_for, :viewers_hover

  def are_allies(user_id1, user_id2)
    user_id1_allies = User.find(user_id1).allies_by_status(:accepted)
    return user_id1_allies.include? User.find(user_id2)
  end

  def is_viewer(viewers)
    if (viewers.include? current_user.id)
      return true
    end

    return false
  end

  def get_uid(user_id)
    uid = User.where(id: user_id).first.uid
    return uid
  end

## Taxonomies are used for pluralization?
## unless the pluralization is non-standard, Rails can do this with .pluralize.

  def no_taxonomies_error(taxonomy)
    return "<span id='#{taxonomy}_quick_button' class='link_style small_margin_top'>Add #{taxonomy}</span>".html_safe
  end

  def fetch_taxonomies(data, data_type, item, taxonomy, show, list)
    if taxonomy == "category" && Category.where(:id => item.to_i).exists?
      if !Category.where(:id => item.to_i).first.description.blank?
        link_name = Category.where(:id => item.to_i).first.name
        link_url = '/categories/' + item.to_s
        if show
          link_url += '?' + data_type.to_s + '=' + data.id.to_s
        end
        return_this = link_to link_name, link_url
      else
        return_this = Category.where(:id => item.to_i).first.name
      end
      if item != data.category.last and list
        return_this += ', '
      end
    elsif taxonomy == "mood" && Mood.where(:id => item.to_i).exists?
      if !Mood.where(:id => item.to_i).first.description.blank?
        link_name = Mood.where(:id => item.to_i).first.name
        link_url = '/moods/' + item.to_s
        if show
          link_url += '?' + data_type.to_s + '=' + data.id.to_s
        end
        return_this = link_to link_name, link_url
      else
        return_this = Mood.where(:id => item.to_i).first.name
      end
      if item != data.mood.last and list
        return_this += ', '
      end
    elsif taxonomy == "strategy" && Strategy.where(:id => item.to_i).exists?
      if !Strategy.where(:id => item.to_i).first.description.blank?
        link_name = Strategy.where(:id => item.to_i).first.name
        link_url = '/strategies/' + item.to_s
        if show
          link_url += '?' + data_type.to_s + '=' + data.id.to_s
        end
        return_this = link_to link_name, link_url
      else
        return_this = Strategy.where(:id => item.to_i).first.name
      end
      if item != data.strategies.last and list
        return_this += ', '
      end
    end

    return return_this
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

  def print_list_links(data)
    first_element = 0
    return_this = ''
    data.each do |d|
      if d.kind_of?(Array) && d[0].kind_of?(String) && d[1].kind_of?(String)
        first_element = first_element + 1
        if first_element == 1
          return_this = link_to d[0], d[1]
        else
          return_this += ", "
          return_this += link_to d[0], d[1]
        end
      else
        return_this = ''
        break
      end
    end

    return return_this.html_safe
  end

  def most_focus(data_type, profile)
    data = Array.new

    if profile.blank?
      user_id = current_user.id
    else
      user_id = profile
    end

    if data_type == 'category'
      Moment.where(user_id: user_id).all.each do |moment|
        if !moment.category.blank? && moment.category.length > 0 && (profile.blank? || (!profile.blank? && (current_user.id == profile || moment.viewers.include?(current_user.id))))
          data += moment.category
        end
      end
      Strategy.where(user_id: user_id).all.each do |strategy|
        if !strategy.category.blank? && strategy.category.length > 0 && (profile.blank? || (!profile.blank? && (current_user.id == profile || strategy.viewers.include?(current_user.id))))
          data += strategy.category
        end
      end
    elsif data_type == 'mood'
      Moment.where(user_id: user_id).all.each do |moment|
        if !moment.mood.blank? && moment.mood.length > 0 && (profile.blank? || (!profile.blank? && (current_user.id == profile || moment.viewers.include?(current_user.id))))
          data += moment.mood
        end
      end
    elsif data_type == 'strategy'
      Moment.where(user_id: user_id).all.each do |moment|
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

  def tag_usage(data, data_type, user_id)
    result = Array.new
    if (data_type == 'category')
      moments = Array.new
      Moment.where(user_id: user_id).order("created_at DESC").all.each do |moment|
        if !moment.category.blank? && moment.category.length > 0 && moment.category.include?(data.to_i)
          moments.push(moment.id)
        end
      end
      result.push(moments)

      strategies = Array.new
      Strategy.where(user_id: user_id).order("created_at DESC").all.each do |strategy|
        if !strategy.category.blank? && strategy.category.length > 0 && strategy.category.include?(data.to_i)
          strategies.push(strategy.id)
        end
      end
      result.push(strategies)
    elsif (data_type == 'mood')
      Moment.where(user_id: user_id).order("created_at DESC").all.each do |moment|
        if !moment.mood.blank? && moment.mood.length > 0 && moment.mood.include?(data.to_i)
          result.push(moment.id)
        end
      end
    elsif (data_type == 'strategy')
      Moment.where(user_id: user_id).order("created_at DESC").all.each do |moment|
        if !moment.strategies.blank? && moment.strategies.length > 0 && moment.strategies.include?(data.to_i)
          result.push(moment.id)
        end
      end
    end

    return result
  end

  def generate_comment(data, data_type)
    profile = User.where(:id => data.user_id).first
    profile_picture = fetch_profile_picture(profile.avatar.url, 'mini_profile_picture')

    comment_info = link_to profile.name, profile_index_path(uid: get_uid(data.user_id))
    if !are_allies(current_user.id, data.user_id) && current_user.id != data.user_id
      comment_info += ' ' + t('shared.comments.not_allies')
    end
    comment_info += ' - '
    comment_info += local_time_ago(data.created_at)

    comment_text = raw(data.comment)

    if data_type == 'moment'
      moment_user = Moment.where(id: data.commented_on).first.user_id
      if data.visibility == 'private' && (data.user_id == current_user.id || current_user.id == moment_user || (!data.viewers.blank? && data.viewers.include?(current_user.id)))
        visibility = '<div class="subtle">'

        if User.where(id: data.viewers[0]).exists? && Moment.where(id: data.commented_on).first.user_id == current_user.id
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: data.viewers[0]).first.name
        elsif Moment.where(id: data.commented_on).first.user_id == current_user.id
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: data.user_id).first.name
        else
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: Moment.where(id: data.commented_on).first.user_id).first.name
        end

        visibility += '</div>'
      end
    elsif data_type == 'strategy'
      strategy_user = Strategy.where(id: data.commented_on).first.user_id
      if data.visibility == 'private' && (data.user_id == current_user.id || current_user.id == strategy_user || (!data.viewers.blank? && data.viewers.include?(current_user.id)))
        visibility = '<div class="subtle">'

        if User.where(id: data.viewers[0]).exists? && Strategy.where(id: data.commented_on).first.user_id == current_user.id
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: data.viewers[0]).first.name
        elsif Strategy.where(id: data.commented_on).first.user_id == current_user.id
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: data.user_id).first.name
        else
          visibility += t('shared.comments.visible_only_between_you_and') + ' ' + User.where(id: Strategy.where(id: data.commented_on).first.user_id).first.name
        end

        visibility += '</div>'
      end
    end

    if (data_type == 'moment' && (Moment.where(id: data.commented_on, user_id: current_user.id).exists? || data.user_id == current_user.id)) || (data_type == 'strategy' && (Strategy.where(id: data.commented_on, user_id: current_user.id).exists? || data.user_id == current_user.id)) || (data_type == 'meeting' && (MeetingMember.where(meetingid: data.commented_on, user_id: current_user.id, leader: true).exists? || data.user_id == current_user.id))
      delete_comment = '<div class="table_cell delete_comment">'
      delete_comment += link_to raw('<i class="fa fa-times"></i>'), '', id: 'delete_comment_' + data.id.to_s, class: 'delete_comment_button'
      delete_comment += '</div>'
    end

    result = { commentid: data.id, profile_picture: profile_picture, comment_info: comment_info, comment_text: comment_text, visibility: visibility, delete_comment: delete_comment, no_save: false }

    return result
  end

  def get_stories(user, include_allies)
    if user.id == current_user.id
      my_moments = Moment.where(user_id: user.id).all.order("created_at DESC")
      my_strategies = Strategy.where(user_id: user.id).all.order("created_at DESC")
    end

    if include_allies && user.id == current_user.id
      allies = user.allies_by_status(:accepted)
      ally_moments = []
      ally_strategies = []

      allies.each do |ally|
        Moment.where(user_id: ally.id).all.order("created_at DESC").each do |moment|
          if moment.viewers.include?(user.id)
            ally_moments << moment
          end
        end

        Strategy.where(user_id: ally.id).all.order("created_at DESC").each do |strategy|
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

      Moment.where(user_id: user.id).all.order("created_at DESC").each do |moment|
        if moment.viewers.include?(current_user.id)
          ally_moments << moment
        end
      end

      Strategy.where(user_id: user.id).all.order("created_at DESC").each do |strategy|
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
    count = Moment.where(user_id: current_user.id).all.count

    if count > 1
      result += '<div class="center" id="stats">'
      result += 'You have written a <strong>total</strong> of '
      result += '<strong>' + count.to_s + '</strong>'

      if count == 1
        result += ' moment.'
      else
        result += ' moments.'

        monthly_count = Moment.where(user_id: current_user.id, created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).all.count
        if count != monthly_count
          result += ' This <strong>month</strong> you wrote '
          result += '<strong>' + monthly_count.to_s + '</strong>'

          if monthly_count == 1
            result += ' moment.'
          else
            result += ' moments.'
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
      Moment.where(user_id: data.user_id).all.order("created_at DESC").each do |moment|
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
        Strategy.where(user_id: data.user_id).all.order("created_at DESC").each do |strategy|
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
        viewers += ' and '
      elsif data.last == viewer && data.length > 1 &&  data.length != 2
        viewers += ', and '
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
end
