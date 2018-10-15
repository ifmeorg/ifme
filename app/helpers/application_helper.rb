# frozen_string_literal: true

# rubocop:disable ModuleLength
module ApplicationHelper
  include ViewersHelper

  def html_options
    { class: 'htmlOptions' }
  end

  def i18n_set?(key)
    I18n.t key, raise: true
  rescue I18n::MissingTranslationData
    false
  end

  def active?(link_path, environment = {})
    current_page?(link_path) ||
      current_controller?(link_path, environment) ||
      (link_path == new_user_session_path && sign_in_path?) ||
      (link_path == new_user_registration_path && join_path?)
  end

  def sign_in_path?
    correct_devise_page?(new_user_session_path,
                         'sessions', 'new')
  end

  def join_path?
    correct_devise_page?(new_user_registration_path,
                         'registrations', 'create') ||
      correct_devise_page?(new_user_registration_path,
                           'registrations', 'new')
  end

  def forgot_password_path?
    correct_devise_page?(new_user_password_path,
                         'devise/passwords', 'new') ||
      correct_devise_page?(new_user_password_path,
                           'devise/passwords', 'create')
  end

  def update_account_path?
    correct_devise_page?(edit_user_registration_path,
                         'registrations', 'update') ||
      correct_devise_page?(edit_user_registration_path,
                           'registrations', 'edit')
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
                         'users/invitations', 'edit')
    correct_devise_page?(accept_user_invitation_path,
                         'users/invitations', 'update')
  end

  def reset_password_path?
    correct_devise_page?(edit_user_password_path,
                         'devise/passwords', 'edit') ||
      correct_devise_page?(edit_user_password_path,
                           'devise/passwords', 'update')
  end

  def secret_share_path?
    params[:controller] == 'secret_shares' && action_name == 'show'
  end

  def static_page?
    non_devise_paths = [
      about_path, resources_path, faq_path,
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
      html += "<i class=\"#{get_icon_class(icon)} smallMarginRight\"></i>"
      html += text
    end
    html.html_safe
  end

  def image_link_to(image_path, url, image_tag_options = {},
                    link_to_options = {})
    link_to url, link_to_options do
      default_alt = File.basename(image_path, '.*')
                        .sub(/-[[:xdigit:]]{32,64}\z/, '')
                        .tr('-_', ' ').capitalize
      image_tag image_path, { alt: default_alt }.merge(image_tag_options)
    end
  end

  private

  def current_controller?(link_path, environment = {})
    current_controller = params[:controller]
    link_controller = Rails.application.routes
                           .recognize_path(link_path, environment)[:controller]
    current_controller != 'profile' &&
      current_controller != 'pages' &&
      current_controller == link_controller
  end

  def correct_devise_page?(path, current_controller, current_action)
    current_page?(path) ||
      (params[:controller] == current_controller &&
        action_name == current_action)
  end
end
# rubocop:enable ModuleLength
