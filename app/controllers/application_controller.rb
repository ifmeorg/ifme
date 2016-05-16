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
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  	before_filter :configure_permitted_parameters, if: :devise_controller?

  	protected

  	def configure_permitted_parameters
  		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:location, :name, :email, :password, :password_confirmation, :current_password, :timezone, :about, :avatar, :comment_notify, :ally_notify, :group_notify, :meeting_notify) }

  		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:location, :name, :email, :password, :password_confirmation, :current_password, :timezone) }
	end

	helper_method :fetch_taxonomies, :fetch_supporters, :avatar_url, :fetch_profile_picture, :no_taxonomies_error, :is_viewer, :are_allies, :print_list_links, :get_uid, :most_focus, :tag_usage, :can_notify

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

	def fetch_supporters(support, type)
		supporters = false
		first_element = 0
		return_this = ''
		support.each do |s|
			if s.support_ids.include?(type.id)
				supporters = true
				first_element = first_element + 1
				link_url = '/profile?userid=' + s.userid.to_s
				if first_element == 1
					if s.userid == current_user.id
         				return_this = link_to "You", link_url
         			else
         				return_this = link_to User.where(:id => s.userid).first.name, link_url
         			end
         		else
         			return_this += ", "
         			if s.userid == current_user.id
         				return_this += link_to "You", link_url
         			else
         				return_this += link_to User.where(:id => s.userid).first.name, link_url
         			end
         		end
      		end
      	end

      	if supporters
      		return_this = "<br><strong>Supporters:</strong> " + return_this
      	else
      		return_this = ""
      	end

      	return return_this.html_safe
	end

	def fetch_profile_picture(avatar, class_name)
		if avatar
			profile = avatar
		else 
			profile = "/assets/default_ifme_avatar.png"
		end

		result = "<div class='" + class_name.to_s + "' style='background: url(" + profile + ")'></div>"

		return result.html_safe
	end

	def print_list_links(data)
		first_element = 0
		return_this = ''
		data.each do |d|
			first_element = first_element + 1
			if first_element == 1
     			return_this = link_to d[0], d[1]
     		else
     			return_this += ", "
     			return_this += link_to d[0], d[1]
     		end
      	end

      	return return_this.html_safe
	end

	def most_focus(data_type)
		data = Array.new
		if data_type == 'category'
			Moment.where(userid: current_user.id).all.each do |moment|
				if !moment.category.blank? && moment.category.length > 0
					data += moment.category
				end
			end
			Strategy.where(userid: current_user.id).all.each do |strategy|
				if !strategy.category.blank? && strategy.category.length > 0
					data += strategy.category
				end
			end
		elsif data_type == 'mood'
			Moment.where(userid: current_user.id).all.each do |moment|
				if !moment.mood.blank? && moment.mood.length > 0
					data += moment.mood
				end
			end
		elsif data_type == 'strategy'
			Moment.where(userid: current_user.id).all.each do |moment|
				if !moment.strategies.blank? && moment.strategies.length > 0
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
end
