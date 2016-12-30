module ApplicationHelper
  include LocalTimeHelper, ViewersHelper

  def nav_link_to(body, url, html_options = {})
    environment = html_options[:method] ? { method: html_options[:method] } : {}
    active_class = is_active?(url, environment) ? 'active' : nil

    content_tag :li, class: active_class do
      link_to body, url, html_options
    end
  end

  def is_active?(link_path, environment = {})
    current_controller = params[:controller]
    link_controller = Rails.application.routes.recognize_path(link_path, environment)[:controller]

    nested_controllers = {
      'moments' => %w(categories moods)
    }

    # Current page.
    current_page?(link_path) ||
      # Current controller.
      (current_controller != 'profile' && current_controller != 'pages' && current_controller == link_controller) ||
      # Parent of the active controller.
      (nested_controllers[link_controller] &&
       nested_controllers[link_controller].include?(current_controller)) ||
      # New user session with devise.
      (link_path == new_user_session_path &&
       current_controller == 'devise/sessions' && action_name == 'new') ||
      # New user registration with devise.
      (link_path == new_user_registration_path &&
       current_controller == 'devise/registrations' && action_name == 'create')
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def page_new(page_new_path)
    content_for(:page_new) { page_new_path }
  end
end
