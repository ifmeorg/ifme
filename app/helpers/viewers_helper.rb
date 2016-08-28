# helper for _viewers_indicators partial
module ViewersHelper
  def number_of_viewers(current_user_id, strategy_owner_id, viewers)
    if strategy_owner_id == current_user_id
      viewer_names = viewers.map { |id| User.where(id: id).first.name }
      t('shared.viewers_indicator.viewers_html',
        count: viewers.count,
        names: viewer_names.to_sentence)
    else
      t('shared.viewers_indicator.you_are_viewer_html', count: viewers.length)
    end
  end
end
