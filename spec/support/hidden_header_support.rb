# frozen_string_literal: true

module HiddenHeaderSupport
  def open_header_if_hidden
    hamburger_id = '#headerHamburger'
    find(hamburger_id).click if has_css?(hamburger_id)
  end
end
