# frozen_string_literal: true

module ContentNavHelper
  include ApplicationHelper

  def content_nav_link_to(label, url, html_options = {})
    environment = html_options[:method] ? { method: html_options[:method] } : {}
    active_class = active?(url, environment) ? 'contentNavLinksActive' : ''
    html_options[:class] = active_class
    link_to(label, url, html_options)
  end
end
