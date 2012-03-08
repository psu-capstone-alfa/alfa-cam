module CoursesHelper
  def course_status_label(course)
    if course.created_term_id != @term.id
      content_tag(:span, 'Retired', class: 'label label-important')
    else
      content_tag(:span, 'Created', class: 'label label-info')
    end
  end
end