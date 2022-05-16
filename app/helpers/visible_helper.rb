# frozen_string_literal: true
module VisibleHelper
  def get_visible(visible)
    return t('shared.stats.visible_in_stats') if visible
  end
end
