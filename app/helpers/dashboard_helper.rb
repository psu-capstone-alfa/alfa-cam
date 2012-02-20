module DashboardHelper
  # Takes an offering and a stage(like :review, :content, ...)
  # Returns a css class color ('green','yellow', 'red')
  def stage_color(offering, stage)
    if offering.complete_stages.include?(stage)
      "green"
    elsif offering.started_stages.include?(stage)
      "yellow"
    else
      "red"
    end
  end
end
