module UserRelation
	mattr_accessor :myself, :ally, :incoming_request, :outgoing_request, :other
	MYSELF = 0
	ALLY = 1
	INCOMING_REQUEST = 2
	OUTGOING_REQUEST = 3
	OTHER = 4
end

module AllyStatus
	mattr_accessor :accepted, :pending_from_userid1, :pending_from_userid2
	ACCEPTED = 0
	PENDING_FROM_USERID1 = 1
	PENDING_FROM_USERID2 = 2
end

class ApplicationController < ActionController::Base
	include ActionView::Helpers::UrlHelper
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception
  	before_filter :configure_permitted_parameters, if: :devise_controller?

  	protected

  	def configure_permitted_parameters
  		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:location, :name, :email, :password, :password_confirmation, :current_password, :timezone, :about, :avatar) }

  		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:location, :name, :email, :password, :password_confirmation, :current_password, :timezone) }
	end

	helper_method :fetch_taxonomies, :fetch_supporters, :avatar_url, :are_allies, :fetch_profile_picture, :get_accepted_allies, :get_incoming_ally_requests, :get_outgoing_ally_requests, :are_allies, :are_pending_allies, :user_relation

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
      		return_this = "Supporters: " + return_this
      	else
      		return_this = ""
      	end

      	return return_this.html_safe
	end

	def get_accepted_allies(userid)
		userid1s = Ally.where(userid1: userid, status: AllyStatus::ACCEPTED).pluck(:userid2)
    	userid2s = Ally.where(userid2: userid, status: AllyStatus::ACCEPTED).pluck(:userid1)
    	return userid1s + userid2s
	end

	def get_outgoing_ally_requests(userid)
		userid1s = Ally.where(userid1: userid, status: AllyStatus::PENDING_FROM_USERID1).pluck(:userid2)
    	userid2s = Ally.where(userid2: userid, status: AllyStatus::PENDING_FROM_USERID2).pluck(:userid1)
    	return userid1s + userid2s
	end

	def get_incoming_ally_requests(userid)
		userid1s = Ally.where(userid1: userid, status: AllyStatus::PENDING_FROM_USERID2).pluck(:userid2)
    	userid2s = Ally.where(userid2: userid, status: AllyStatus::PENDING_FROM_USERID1).pluck(:userid1)
    	return userid1s + userid2s
	end

	def are_allies(userid1, userid2)
		return get_accepted_allies(userid1).include? userid2.to_i
	end

	# A is a pending ally of B if A sent B an ally request
	def are_pending_allies(userid1, userid2)
		return get_outgoing_ally_requests(userid1).include? userid2.to_i
	end

	def user_relation(userid1, userid2)
		type = UserRelation::OTHER
		if userid1 == userid2
			type = UserRelation::MYSELF
		elsif are_allies(userid1, userid2)
			type = UserRelation::ALLY
		elsif are_pending_allies(userid2, userid1)
			type = UserRelation::INCOMING_REQUEST
		elsif are_pending_allies(userid1, userid2)
			type = UserRelation::OUTGOING_REQUEST
		end

		return type
	end

	def fetch_profile_picture(avatar)
		if avatar
			return avatar
		end

		return "default_ifme_avatar.png"
	end

end
