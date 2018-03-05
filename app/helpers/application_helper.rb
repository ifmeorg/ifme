# frozen_string_literal: true

module ApplicationHelper
  include ViewersHelper

  def nav_link_to(body, url, html_options = {})
    environment = html_options[:method] ? { method: html_options[:method] } : {}
    active_class = active?(url, environment) ? 'active' : nil

    content_tag :li, class: active_class do
      link_to body, url, html_options
    end
  end

  # rubocop:disable MethodLength
  def active?(link_path, environment = {})
    current_controller = params[:controller]
    link_controller = Rails.application.routes
                           .recognize_path(link_path, environment)[:controller]

    nested_controllers = {
      'moments' => %w[categories moods]
    }

    # Current page.
    current_page?(link_path) ||
      # Current controller.
      (
        current_controller != 'profile' &&
        current_controller != 'pages' &&
        current_controller == link_controller
      ) ||
      # Parent of the active controller.
      (nested_controllers[link_controller]&.include?(current_controller)) ||
      # New user session with devise.
      (link_path == new_user_session_path &&
       current_controller == 'devise/sessions' && action_name == 'new') ||
      # New user registration with devise.
      (link_path == new_user_registration_path &&
       current_controller == 'devise/registrations' && action_name == 'create')
  end
  # rubocop:enable MethodLength

  def title(page_title)
    content_for(:title) { page_title }
  end

  def page_new(page_new_path)
    content_for(:page_new) { page_new_path }
  end

  # rubocop:disable RescueStandardError
  def i18n_set?(key)
    I18n.t key, raise: true
  rescue
    false
  end
  # rubocop:enable RescueStandardError

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
end
