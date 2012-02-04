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

    home = { home: root_path }
    [:instructor, :staff, :reviewer].each do |role|
      home[role] = root_path if current_user.is? role
    end
    home = home.values[1] if home.length == 2

    {
      home: home,
      offerings: offerings_path,
      terms: academic_terms_path,
      outcomes: outcomes_path
    }
  end

  def active_section?(section)
    ''
    'active' if @nav_section.is_a? Array and @nav_section.include? section
    'active' if @nav_section == section
  end

  def active_sections?(sections)
    ''
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


end
