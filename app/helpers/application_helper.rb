module ApplicationHelper
  # twitter-bootstrap form builder
  def bs_form_for(object, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    form_for(object, options, &block)
  end

  # twitter-bootstrap fields
  def bs_fields_for(record_name, record_object = nil, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    fields_for(record_name, record_object, options, &block)
  end

  # default form builder
  def no_bs_form_for(object, options = {}, &block)
    options[:builder] = ActionView::Helpers::FormBuilder
    form_for(object, options, &block)
  end

  # default fields
  def no_bs_fields_for(record_name, record_object = nil, options = {}, &block)
    options[:builder] = ActionView::Helpers::FormBuilder
    fields_for(record_name, record_object, options, &block)
  end

  def nav_bar_spec()
    if current_user.nil?
      return { home: root_path }
    end

    home = { }
    [:instructor, :staff, :reviewer].each do |role|
      home[role] = send("home_#{role.to_s}_path") if current_user.is? role
    end
    home[:instructor_status] = home_staff2_path if current_user.is? :staff

    home = case home.length
      when 1
        home.values[0]
      when 0
        root_path
      else
        home
    end

    {
      dashboard: home,
      offerings: offerings_path,
      terms: academic_terms_path,
      outcomes: outcome_groups_path,
      users: users_path,
    }
  end

  def active_section?(section)
    'active' if @nav_section.is_a? Array and @nav_section.include? section
    'active' if @nav_section == section
  end

  def active_sections?(sections)
    if @nav_section.is_a? Array
      sections.each do |section|
        return 'active' if @nav_section.include? section
      end
    else
      sections.each do |section|
        return 'active' if @nav_section == section
      end
    end
  end

  def empty_row
    content_tag :div, class: 'row' do
      content_tag :br
    end
  end

  # a generic means for displaying an error notice on forms
  def errors_for(object, show_full_error = false)
    object_type = object.class.table_name.singularize.titleize.downcase
    render partial: 'misc/error', locals: {
      object: object,
      object_type: object_type,
      show_full_error: show_full_error
    }
  end

end
