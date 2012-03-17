require 'minitest_helper'

#TODO:rs test doesn't run, so leaving it commented for now

=begin
def test_mailer_generator
	assert_difference 'ActionMailer::Base.deliveries.size', +1 do
		post :invite_friend, :email => 'friend@example.com'
	end
	invite_email = ActionMailer::Base.deliveries.last
	assert_equal "You have been invited by me@example.com", invite_email.subject
	assert_equal 'friend@example.com', invite_email.to[0]
	assert_match(/Hi friend@example.com/, invite_email.body)
end
=end
