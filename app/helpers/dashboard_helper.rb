module DashboardHelper
  # Takes an offering and a stage(like :review, :content, ...)
  # Returns a css class color ('green','yellow', 'red')
  def stage_color(offering, stage)
    if offering.complete_stages.include?(stage)
      "btn-success"
    elsif offering.started_stages.include?(stage)
      "btn-warning"
    else
      "btn-danger"
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
          'btn-success'
        when started.include?(stage)
          'btn-warning'
        else
          'btn-danger'
      end
    end
    output
  end
end
