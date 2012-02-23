module UsersHelper
  def user_role_labels(user,instructors=false)
    output = ''.html_safe
    user.roles.each do |role|
      output << ' ' << case role
        when :reviewer
          content_tag(:span, 'Reviewer', class: 'label label-info')
        when :instructor
          content_tag(:span, 'Instructor', class: 'label') if instructors
        when :staff
          content_tag(:span, 'Staff', class: 'label label-success')
        when :admin
          content_tag(:span, 'Admin', class: 'label label-warning')
        else
          ''
      end
    end
    if user.roles.empty?
      output << content_tag(:span, 'Disabled', class: 'label label-important')
    end
    output
  end
end
