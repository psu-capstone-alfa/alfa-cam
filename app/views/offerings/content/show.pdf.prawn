# pdf format of content show page
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
  break unless group.content.count > 0
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
