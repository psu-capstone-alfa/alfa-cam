module OfferingsHelper
  def stage_navbar_link(stage)
    ready = @offering.ready_stages.include?(stage)
    classes = []
    classes << active_if(@nav_offering, stage)
    classes << 'disabled' unless ready
    classes << stage_navbar_color(stage)

    content_tag :li, class: classes.join(' ') do
      if ready
        link_to stage.to_s.humanize, [@offering, stage]
      else
        content_tag :a, stage.to_s.humanize
      end
    end
  end

  def stage_navbar_color(stage)
    case
    when @offering.is_complete?(stage)
      'green'
    when @offering.is_started?(stage)
      'yellow'
    else
      'red'
    end
  end

  def redirect_token(path)
    hidden_field_tag '_redirect_endpoint', path
  end

  def stage_label_color(offering, stage)
    if offering.complete_stages.include?(stage)
      "label-success"
    elsif offering.started_stages.include?(stage)
      "label-warning"
    else
      "label-important"
    end
  end

end
