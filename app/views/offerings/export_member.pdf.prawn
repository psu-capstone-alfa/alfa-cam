# pdf format of content show page
pdf.text " ",:leading => 5
pdf.text "<font size='16'><b>#{@offering.course.dept_code} #{@offering.course.course_num} : #{@offering.course.title}</b></font>", :inline_format => true
pdf.text " ",:leading => 5
pdf.text "<font size='16'><b>#{@offering}</b></font>", :inline_format => true
pdf.text " ",:leading => 5

pdf.text "<font size='16'><b>OFFERING CONTENTS</b></font>", :inline_format => true

pdf.text " ",:leading => 5

# array of Outcome Key
arrKey = []
@offering.outcomes.each do |outcome|
  arrKey.push(outcome.key)
end

content_groups = @offering.content_groups.each do |group|

  allRows = []  # 2D array of all Rows

  titleRow = [group.name] # title row include name and Outcome keys
  titleRow.concat(arrKey)

  allRows.push(titleRow)

  #  add rows, each row is a content and mapping value
  group.content.each do |content|
    aRow = []
    aRow.push(content.title)
    content.mappings.each do |mapping|
      aRow.push(mapping.value)
    end
    allRows.push(aRow)
  end

  pdf.table(allRows, :row_colors => ["FFFFFF","DDDDDD"])
  pdf.text " ",:leading => 5

end

start_new_page

# pdf format of objective show page
pdf.text " ",:leading => 5
pdf.text "<font size='16'><b>OFFERING OBJECTIVES</b></font>", :inline_format => true
pdf.text " ",:leading => 5

arrKey = []
@offering.outcomes.each do |outcome|
  arrKey.push(outcome.key)
end

allRows = []  # 2D array of all Rows

titleRow = [" "] # title row include name and Outcome keys
titleRow.concat(arrKey)

allRows.push(titleRow)

objectives = @offering.objectives
objectives.each do |objective| 
  aRow = []
  aRow.push(objective.description)
  objective.mappings.each do |mapping| 
    if mapping.value and mapping.value > 0
      aRow.push("X")
    else
      aRow.push(" ")
    end
  end
  allRows.push(aRow)
end

pdf.table(allRows, :row_colors => ["FFFFFF","DDDDDD"])

start_new_page

# pdf format of assessment show page
assessment = @offering.assessment
unless assessment.nil?
	pdf.text " ",:leading => 5
	pdf.text "<font size='16'><b>OFFERING ASSESSMENTS</b></font>", :inline_format => true
	pdf.text " ",:leading => 5
	assessment.objective_assessments.each do |obj|
	  pdf.text "<b>Objective:</b>  #{obj.objective}", :inline_format => true
	  pdf.text "<b>Assessed:</b>  #{obj.assessed}", :inline_format => true
	  pdf.text "<b>How well met:</b>  #{obj.well_met}", :inline_format => true
	  pdf.text "<b>Improved:</b>  #{obj.improved}", :inline_format => true
	  pdf.text " ",:leading => 5
	end
	pdf.text " ",:leading => 5
	pdf.text "<b>Improved:</b>  #{assessment.improved}", :inline_format => true
	pdf.text "<b>Comments:</b>  #{assessment.comments}", :inline_format => true
end