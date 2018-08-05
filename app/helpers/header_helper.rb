# frozen_string_literal: true

module HeaderHelper
  def header_props
    links = basic_links
    if user_signed_in?
      links += add_signed_in_links
    else
      links += add_not_signed_in_links
    end
    {
      home: { name: t('app_name'), url: root_path },
      links: links
    }
  end

  private

  def add_signed_in_links
    signout = {name: t('shared.header.signout'), url: destroy_user_session_path}
    signout[:active] = active?(signout[:url])
    [signout]
  end

  def add_not_signed_in_links
    join = {name: t('common.actions.join'), url: new_user_registration_path}
    join[:active] = active?(join[:url])
    sign_in = {name: t('account.sign_in'), url: new_user_session_path}
    sign_in[:active] = active?(sign_in[:url])
    [join, sign_in]
  end

  def basic_links
    about = {name: t('navigation.about'), url: about_path}
    about[:active] = active?(about[:url])
    blog = {name: t('navigation.blog'), url: blog_path}
    blog[:active] = active?(blog[:url])
    resources = {name: t('navigation.resources'), url: resources_path}
    resources[:active] = active?(resources[:url])
    [about, blog, resources]
  end
end
