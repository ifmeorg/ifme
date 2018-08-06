# frozen_string_literal: true

module ApplicationHelper
  include ViewersHelper

  # rubocop:disable RescueStandardError
  def i18n_set?(key)
    I18n.t key, raise: true
  rescue
    false
  end
  # rubocop:enable RescueStandardError

  # rubocop:disable MethodLength
  def active?(link_path, environment = {})
    current_controller = params[:controller]
    link_controller = Rails.application.routes
                           .recognize_path(link_path, environment)[:controller]
    # Current page.
    current_page?(link_path) ||
      # Current controller.
      (
        current_controller != 'profile' &&
        current_controller != 'pages' &&
        current_controller == link_controller
      ) ||
      # New user session with devise.
      (link_path == new_user_session_path &&
       current_controller == 'devise/sessions' && action_name == 'new') ||
      # New user registration with devise.
      (link_path == new_user_registration_path &&
       current_controller == 'devise/registrations' && action_name == 'create')
  end
  # rubocop:enable MethodLength

  def sign_in_path?
    correct_devise_page?(new_user_session_path,
                         'devise/sessions', 'new')
  end

  def join_path?
    correct_devise_page?(new_user_registration_path,
                         'devise/registrations', 'create')
  end

  def forgot_password_path?
    correct_devise_page?(new_user_password_path,
                         'devise/passwords', 'new')
  end

  def update_account_path?
    correct_devise_page?(edit_user_registration_path,
                         'registrations', 'update')
  end

  def not_signed_in_root_path?
    current_page?(root_path) && !user_signed_in?
  end

  def send_ally_invitation_path?
    correct_devise_page?(new_user_invitation_path,
                         'devise/invitations', 'new') ||
      correct_devise_page?(new_user_invitation_path,
                           'users/invitations', 'create')
  end

  def ally_accept_invitation_path?
    correct_devise_page?(accept_user_invitation_path,
                         'devise/invitations', 'accept')
  end

  def reset_password_path?
    correct_devise_page?(edit_user_password_path,
                         'devise/passwords', 'edit')
  end

  def static_page?
    non_devise_paths = [
      about_path, blog_path, resources_path, faq_path,
      contribute_path, partners_path, press_path, privacy_path
    ]
    non_devise_paths = non_devise_paths.select { |path| active?(path) }
    devise = ally_accept_invitation_path? || reset_password_path?
    devise || non_devise_paths.count == 1
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def page_new(page_new_path)
    content_for(:page_new) { page_new_path }
  end

  def get_icon_class(icon)
    if %w[envelope gift rss].include?(icon)
      "fas fa-#{icon}"
    elsif icon == 'money-bill-alt'
      'far fa-money-bill-alt'
    elsif %w[facebook github instagram medium twitter].include?(icon)
      "fab fa-#{icon}"
    else
      'fa fa-globe'
    end
  end

  def get_icon_text(icon, text)
    html = ''
    if icon && text
      html += "<i class=\"#{get_icon_class(icon)} smaller_margin_right\"></i>"
      html += text
    end
    html.html_safe
  end

  def image_link_to(image_path, url, image_tag_options = {},
                    link_to_options = {})
    link_to url, link_to_options do
      image_tag image_path, image_tag_options
    end
  end

  private

  def correct_devise_page?(path, current_controller, current_action)
    current_page?(path) ||
      (params[:controller] == current_controller &&
        action_name == current_action)
  end
end
