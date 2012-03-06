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

  # Returns a hash of stage => color
  def stage_colors(offering)
    completed = offering.complete_stages
    started = offering.started_stages
    output = {}
    Offering::STAGES.each do |stage|
      output[stage] = case
        when completed.include?(stage)
          'green'
        when started.include?(stage)
          'yellow'
        else
          'red'
      end
    end
    output
  end
end
