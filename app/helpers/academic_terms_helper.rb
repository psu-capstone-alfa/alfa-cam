module AcademicTermsHelper
  def format_term_date(date)
    return "None" if date.nil?
    date.strftime("%b %e '%y")
  end
end
