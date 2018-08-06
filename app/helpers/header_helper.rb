# frozen_string_literal: true

module HeaderHelper
  def header_props
    links = basic_links
    links += user_signed_in? ? add_signed_in_links : add_not_signed_in_links
    {
      home: { name: t('app_name'), url: root_path },
      links: links,
      mobileOnly: user_signed_in? ? mobile_only : nil
    }
  end

  private

  def mobile_only
    render partial: 'shared/content_nav'
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
    blog = { name: t('navigation.blog'), url: blog_path }
    blog[:active] = active?(blog[:url])
    resources = { name: t('navigation.resources'), url: resources_path }
    resources[:active] = active?(resources[:url])
    [about, blog, resources]
  end
end
