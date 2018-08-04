# frozen_string_literal: true

module ApplicationHelper
  include ViewersHelper

  # rubocop:disable MethodLength
  def header_props
    if user_signed_in? 
      links = [
        {
          name: t('moments.plural'),
          url: moments_path,
          active: active?(moments_path)
        },
        {
          name: t('categories.plural'),
          url: categories_path,
          active: active?(categories_path)
        },
        {
          name: t('moods.plural'),
          url: moods_path,
          active: active?(moods_path)
        },
        {
          name: t('strategies.plural'),
          url: strategies_path,
          active: active?(strategies_path)
        },
        {
          name: t('medications.index.title'),
          url: medications_path,
          active: active?(medications_path)
        },
        {
          name: t('groups.plural'),
          url: groups_path,
          active: active?(groups_path)
        },
        {
          name: t('allies.index.title'),
          url: allies_path,
          active: active?(allies_path)
        },
        {
          name: t('notifications.plural'),
          url: 'notifications_button'
        },
        {
          name: t('profile.index.title'),
          url: profile_index_path(uid: current_user.uid),
          active: active?(profile_index_path(uid: current_user.uid))
        },
        {
          name: t('account.singular'),
          url: edit_user_registration_path,
          active: active?(edit_user_registration_path)
        },
        {
          name: t('navigation.resources'),
          url: resources_path,
          active: active?(resources_path)
        },
        {
          name: t('shared.header.signout'),
          url: destroy_user_session_path,
          dataMethod: 'delete'
        }
      ]
    else
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
        },
        {
          name: t('common.actions.join'),
          url: new_user_registration_path,
          active: active?(new_user_registration_path)
        },
        {
          name: t('account.sign_in'),
          url: new_user_session_path,
          active: active?(new_user_session_path)
        }
      ]
    end
    {
      home: { name: t('app_name'), url: root_path },
      links: links
    }
  end

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
