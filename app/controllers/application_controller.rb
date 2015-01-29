class ApplicationController < ActionController::Base
	include ActionView::Helpers::UrlHelper
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception
  	before_filter :configure_permitted_parameters, if: :devise_controller?

	protected

  	def configure_permitted_parameters
  		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:location, :firstname, :lastname, :email, :password, :password_confirmation, :current_password, :timezone) }

  		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:location, :firstname, :lastname, :email, :password, :password_confirmation, :current_password, :timezone) }
	end

	helper_method :fetch_categories_moods, :fetch_supporters, :avatar_url, :are_allies

	def fetch_categories_moods(data, data_type, item, category_mood, show)
		if category_mood == "category" && data_type == "trigger" && Category.where(:id => item.to_i).exists?
			if !Category.where(:id => item.to_i).first.description.blank?
				link_name = Category.where(:id => item.to_i).first.name
				link_url = '/categories/' + item.to_s
				if show
					link_url += '?trigger=' + data.id.to_s
				end
				return_this = link_to link_name, link_url
			else
				return_this = Category.where(:id => item.to_i).first.name
			end
			if item != data.category.last
				return_this += ', '
			end
		elsif category_mood == "mood" && data_type == "trigger" && Mood.where(:id => item.to_i).exists?
			if !Mood.where(:id => item.to_i).first.description.blank?
				link_name = Mood.where(:id => item.to_i).first.name
				link_url = '/moods/' + item.to_s
				if show
					link_url += '?trigger=' + data.id.to_s
				end
				return_this = link_to link_name, link_url
			else
				return_this = Mood.where(:id => item.to_i).first.name
			end
			if item != data.mood.last
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
         				return_this = link_to User.where(:id => s.userid).first.firstname + " " + User.where(:id => s.userid).first.lastname, link_url
         			end
         		else
         			return_this += ", "
         			if s.userid == current_user.id
         				return_this += link_to "You", link_url
         			else
         				return_this += link_to User.where(:id => s.userid).first.firstname + " " + User.where(:id => s.userid).first.lastname, link_url
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

	def avatar_url(user)
	    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)

	    return "http://gravatar.com/avatar/#{gravatar_id}.png?s=200"
	end

	def are_allies(user1, user2)
		if Ally.where(:userid => user1).exists? && Ally.where(:userid => user2).exists?
			if Ally.where(:userid => user1).first.allies.include?(user2) && Ally.where(:userid => user2).first.allies.include?(user1)
				return true
			end
		end
		return false
	end

end