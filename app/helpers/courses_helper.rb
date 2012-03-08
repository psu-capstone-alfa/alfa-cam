module CoursesHelper
	def course_status_label(course)
		output = ''.html_safe
		if course.created_term_id != @term.id
			output << content_tag(:span, 'Retired', class: 'label label-important')
		else
			output << content_tag(:span, 'Created', class: 'label label-info')
		end
		output
	end
end