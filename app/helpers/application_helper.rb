# frozen_string_literal: true
module ApplicationHelper
  include ViewersHelper

  def html_options
    { class: 'htmlOptions' }
  end

  def active?(link_path, environment = {})
    current_page?(link_path) ||
      current_controller?(link_path, environment) ||
      (link_path == new_user_session_path && sign_in_path?) ||
      (link_path == new_user_registration_path && join_path?)
  end

  def sign_in_path?
    devise_page?(new_user_session_path, 'sessions', 'new')
  end

  def join_path?
    path = new_user_registration_path
    devise_page?(path, 'registrations', 'create') ||
      devise_page?(path, 'registrations', 'new')
  end

  def forgot_password_path?
    path = new_user_password_path
    devise_page?(path, 'devise/passwords', 'new') ||
      devise_page?(path, 'devise/passwords', 'create')
  end

  def update_account_path?
    path = edit_user_registration_path
    devise_page?(path, 'registrations', 'update') ||
      devise_page?(path, 'registrations', 'edit')
  end

  def not_signed_in_root_path?
    current_page?(root_path) && !user_signed_in?
  end

  def send_ally_invitation_path?
    path = new_user_invitation_path
    devise_page?(path, 'devise/invitations', 'new') ||
      devise_page?(path, 'users/invitations', 'create')
  end

  def ally_accept_invitation_path?
    path = accept_user_invitation_path
    devise_page?(path, 'users/invitations', 'edit') ||
      devise_page?(path, 'users/invitations', 'update')
  end

  def reset_password_path?
    path = edit_user_password_path
    devise_page?(path, 'devise/passwords', 'edit') ||
      devise_page?(path, 'devise/passwords', 'update')
  end

  def secret_share_path?
    params[:controller] == 'secret_shares' && action_name == 'show'
  end

  def static_page?
    non_devise_paths = [
      about_path, resources_path, faq_path,
      contribute_path, partners_path, press_path, privacy_path
    ].select { |path| active?(path) }
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
    return 'far fa-money-bill-alt' if icon == 'money-bill-alt'
    return "fas fa-#{icon}" if %w[envelope gift rss].include?(icon)
    return "fab fa-#{icon}" if %w[
      facebook github instagram medium twitter
    ].include?(icon)

    'fa fa-globe'
  end

  private

  def current_controller?(link_path, environment = {})
    link_controller = Rails.application.routes
                           .recognize_path(link_path, environment)[:controller]
    params[:controller] != 'profile' &&
      params[:controller] != 'pages' &&
      params[:controller] == link_controller
  end

  def devise_page?(path, current_controller, current_action)
    current_page?(path) ||
      (params[:controller] == current_controller &&
        action_name == current_action)
  end
end
