module OfferingsHelper
  def stage_navbar_link(stage)
    ready = @offering.ready_stages.include?(stage)
    classes = []
    classes << active_if(@nav_offering, stage)
    classes << 'disabled' unless ready

    content_tag :li, class: classes.join(' ') do
      if ready
        link_to stage.to_s.humanize, [@offering, stage]
      else
        content_tag :a, stage.to_s.humanize
      end
    end
  end
end
