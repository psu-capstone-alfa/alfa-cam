# pdf format of objective show page
pdf.text "<font size='16'><b>#{@offering.course.dept_code} #{@offering.course.course_num} : #{@offering.course.title}</b></font>", :inline_format => true
pdf.text " ",:leading => 5
pdf.text "<font size='16'><b>#{@offering}</b></font>", :inline_format => true
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

@objectives.each do |objective| 
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