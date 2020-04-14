module TasksHelper
  def present_task(element)
    present_object = { story_type: t('tasks.plural') }
    { name: element.title,
      link: 'strategies/' + element.title.downcase.strip.gsub(' ', '-') + '/edit',
      date: TimeAgo.created_or_edited(element),
      categories: slugs_hash({'Followed ': element.no_of_days_followed.to_s + '/'+ element.total_no_of_days.to_s+' days'}, 'tasks'),
    }
  end

  def task_props(elements)
    elements.map { |element| present_task(element) }
  end

  private

  def slugs_hash(data, model_name)
    data.map { |total_no_of_days| { name: total_no_of_days} }
  end
end
