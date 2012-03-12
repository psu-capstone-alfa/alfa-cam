# pdf format of assessment show page
pdf.text "<font size='20'><b>#{@offering.course.dept_code} #{@offering.course.course_num} : #{@offering.course.title}</b></font>", :inline_format => true
pdf.text " ",:leading => 5
pdf.text "<font size='20'><b>OFFERING ASSESSMENTS</b></font>", :inline_format => true
pdf.text " ",:leading => 5
@assessment.objective_assessments.each do |obj|


  pdf.text "<b>#{obj.objective}</b>", :inline_format => true, :size => 16
  pdf.text " ",:leading => 1

  pdf.text "<b><i>How was the objective assessed?</i></b>", :inline_format => true
  pdf.text "#{obj.assessed}"
  pdf.text " ",:leading => 1

  pdf.text "<b><i>How well met was this objective?</i></b>", :inline_format => true
  pdf.text "#{obj.well_met}"
  pdf.text " ",:leading => 1

  pdf.text "<b><i>How could the objective be improved?</i></b>", :inline_format => true
  pdf.text "#{obj.improved}"
  pdf.text " ",:leading => 1

  pdf.text " ",:leading => 5

end

pdf.text " ",:leading => 5
pdf.text "<b>How could this course be improved?</b>", :inline_format => true,:size => 14
pdf.text "#{@assessment.improved}"
pdf.text " ",:leading => 1
pdf.text "<b>Any additional comments:</b>", :inline_format => true,:size => 14
pdf.text "#{@assessment.comments}"
