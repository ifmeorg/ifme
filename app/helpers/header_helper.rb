# frozen_string_literal: true

module HeaderHelper
  def header_props
    {
      home: { name: t('app_name'), url: root_path },
      profile: user_signed_in? ? profile : nil,
      links: links,
      mobileOnly: user_signed_in? ? mobile_only : nil
    }
  end

  private

  def links
    return basic_links + add_not_signed_in_links unless user_signed_in?
    basic_links + add_signed_in_links
  end

  def account
    {
      name: t('account.singular'),
      url: edit_user_registration_path
    }
  end

  def notifications
    {
      plural: t('notifications.plural'),
      none: t('notifications.none'),
      clear: t('notifications.clear')
    }
  end

  def profile
    {
      avatar: current_user.avatar.url,
      name: current_user.name,
      profile: {
        name: t('profile.index.title'),
        url: profile_index_path(uid: current_user.uid)
      },
      account: account,
      notifications: notifications
    }
  end

  def mobile_only
    render partial: 'shared/dashboard_nav_mobile'
  end

  def add_signed_in_links
    signout = {
      name: t('shared.header.signout'),
      url: destroy_user_session_path,
      dataMethod: 'delete',
      hideInMobile: true
    }
    [signout]
  end

  def add_not_signed_in_links
    join = { name: t('common.actions.join'), url: new_user_registration_path }
    join[:active] = active?(join[:url])
    sign_in = { name: t('account.sign_in'), url: new_user_session_path }
    sign_in[:active] = active?(sign_in[:url])
    [join, sign_in]
  end

  def basic_links
    about = { name: t('navigation.about'), url: about_path }
    about[:active] = active?(about[:url])
    blog = { name: t('navigation.blog'), url: 'https://medium.com/ifme' }
    resources = { name: t('navigation.resources'), url: resources_path }
    resources[:active] = active?(resources[:url])
    [about, blog, resources]
  end
end
