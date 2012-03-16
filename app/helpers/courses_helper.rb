module CoursesHelper
  def course_status_label(course)
    out = ''.html_safe
    if course.created_term_id == @term.id
      out << content_tag(:span, 'Created', class: 'label label-info')
    end
    if course.retired_term_id == @term.id
      out << content_tag(:span, 'Retired', class: 'label label-important')
    end
    out
  end
end
