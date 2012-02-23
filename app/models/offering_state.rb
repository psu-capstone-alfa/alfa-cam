# An offering is an instance of a course taught in a specific term
# by some number of instructors
#
module OfferingState
  # Stage status methods
  STAGES = [:review, :importing, :details, :objectives, :content, :assessments]
  EDITING_STAGES = STAGES - [:review, :importing]

  # FIXME:rs Remove when we have reviewing and importing
  def review_done
    true
  end
  def importing_done
    true
  end

  def populate_stage_status
    # Reset the stage variables
    @ready = []
    @complete = []
    @started = []

    @ready << :review unless review_done
    @complete << :review if review_done

    @ready << :importing if @complete.include?(:review) && !importing_done
    @complete << :importing if importing_done

    @ready << :details if @complete.include?(:importing)
    @complete << :details if details_done
    @started << :details

    @ready << :objectives << :content if @complete.include?(:details)
    @complete << :objectives if objectives_done && @ready.include?(:objectives)
    @started << :objectives unless objectives.empty?
    @complete << :content if content_done && @ready.include?(:content)
    @started << :content unless content.empty?

    assess = :assessments
    @ready << assess if ([:objectives, :content] - @complete).empty?
    @complete << assess if assessments_done && @ready.include?(assess)
    @started << assess if assessment

    @stages_cached = true
  end

  def ready_stages
    populate_stage_status unless @stages_cached
    @ready
  end

  # Green
  def complete_stages
    populate_stage_status unless @stages_cached
    @complete
  end

  # Yellow
  def started_stages
    populate_stage_status unless @stages_cached
    @started
  end

  def completed?
    populate_stage_status unless @stages_cached
    @complete == STAGES
  end

  %w[ready started complete].each do |phase|
    define_method "is_#{phase}?" do |stage|
      # call to_sym to allow strings to be passed
      send("#{phase}_stages").include? stage.to_sym
    end

    STAGES.each do |stage|
      define_method "is_#{stage}_#{phase}?" do
        # no need for to_sym since we're iterating over the array of symbols
        send("#{phase}_stages").include? stage
      end
    end
  end
end
