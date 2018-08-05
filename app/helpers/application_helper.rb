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
    current_page?(new_user_session_path) ||
      (params[:controller] == 'devise/sessions' && action_name == 'new')
  end

  def join_path?
    current_page?(new_user_registration_path) ||
      (params[:controller] == 'devise/registrations' && action_name == 'create')
  end

  def forgot_password_path?
    current_page?(new_user_password_path) ||
      (params[:controller] == 'devise/passwords' && action_name == 'new')
  end

  def update_account_path?
    current_page?(edit_user_registration_path) ||
      (params[:controller] == 'registrations' && action_name == 'update')
  end

  def not_signed_in_root_path?
    current_page?(root_path) && !user_signed_in?
  end

  def send_ally_invitation_path?
    current_page?(new_user_invitation_path) ||
      (params[:controller] == 'devise/invitations' && action_name == 'new') ||
      (params[:controller] == 'users/invitations' && action_name == 'create')
  end

  def ally_accept_invitation_path?
    current_page?(accept_user_invitation_path) ||
      (params[:controller] == 'devise/invitations' && action_name == 'accept')
  end

  def reset_password_path?
    current_page?(edit_user_password_path) ||
      (params[:controller] == 'devise/passwords' && action_name == 'edit')
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

  def content_nav_link_to(label, url, html_options = {})
    environment = html_options[:method] ? { method: html_options[:method] } : {}
    active_class = active?(url, environment) ? 'contentNavLinksActive' : ''
    html_options[:class] = active_class
    link_to(label, url, html_options)
  end

  # rubocop:disable MethodLength
  def header_props
    links = [
      {
        name: t('navigation.about'),
        url: about_path,
        active: active?(about_path)
      },
      {
        name: t('navigation.blog'),
        url: blog_path,
        active: active?(blog_path)
      },
      {
        name: t('navigation.resources'),
        url: resources_path,
        active: active?(resources_path)
      }
    ]
    if user_signed_in? 
      links.push({
        name: t('shared.header.signout'),
        url: destroy_user_session_path,
        dataMethod: 'delete'
      })
    else
      links.push({
        name: t('common.actions.join'),
        url: new_user_registration_path,
        active: active?(new_user_registration_path)
      })
      links.push({
        name: t('account.sign_in'),
        url: new_user_session_path,
        active: active?(new_user_session_path)
      })
    end
    {
      home: { name: t('app_name'), url: root_path },
      links: links
    }
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
end
