# frozen_string_literal: true

module TasksHelper
  def present_task(element)
    {
      name: element.title,
      link: 'strategies/' + element.title.downcase.strip.tr(' ', '-') + '/edit',
      date: TimeAgo.created_or_edited(element),
      categories: slugs_hash({ 'Followed ': element.no_of_days_followed.to_s +
        '/' + element.total_no_of_days.to_s + ' days' })
    }
  end

  def task_props(elements)
    elements.map { |element| present_task(element) }
  end

  private

  def slugs_hash(data)
    data.map { |total_no_of_days| { name: total_no_of_days } }
  end
end
