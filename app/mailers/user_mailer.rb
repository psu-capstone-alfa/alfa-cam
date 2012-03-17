# User Notification Mailer
class UserMailer < ActionMailer::Base
  # Pre/Early term reminder to review course assessments
  def send_start_term_notice(term,instructor)
    @instructor = instructor
    @offerings = instructor.offerings.for_term(term)
    @term = term

    mail({
      to: "#{instructor.name}<#{instructor.email}",
      subject: "Pre-Term Course Review Reminder"
    })
  end

  # Reminder for instructors with incomplete offerings
  def send_red_reminder(instructor)
    @instructor = instructor
    mail({
      to: "#{instructor.name}<#{instructor.email}>",
      subject: "Course Assessment Reminder"
    })
  end
end
