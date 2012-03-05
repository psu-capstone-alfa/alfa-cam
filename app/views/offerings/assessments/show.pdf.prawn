# pdf format of assessment show page
pdf.text "<font size='16'><b>#{@offering.course.dept_code} #{@offering.course.course_num} : #{@offering.course.title}</b></font>", :inline_format => true
pdf.text " ",:leading => 5
pdf.text "<font size='16'><b>OFFERING ASSESSMENTS</b></font>", :inline_format => true
pdf.text " ",:leading => 5
@assessment.objective_assessments.each do |obj|
  pdf.text "<b>Objective:</b>  #{obj.objective}", :inline_format => true
  pdf.text "<b>Assessed:</b>  #{obj.assessed}", :inline_format => true
  pdf.text "<b>How well met:</b>  #{obj.well_met}", :inline_format => true
  pdf.text "<b>Improved:</b>  #{obj.improved}", :inline_format => true
  pdf.text " ",:leading => 5
end
pdf.text " ",:leading => 5
pdf.text "<b>Improved:</b>  #{@assessment.improved}", :inline_format => true
pdf.text "<b>Comments:</b>  #{@assessment.comments}", :inline_format => true