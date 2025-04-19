class UserMailer < ApplicationMailer
  default from: 'no-reply@yourapp.com'

  def reminder_email(user, activities)
    @user = user
    @activities = activities
    @url = 'http://yourapp.com/activities'
    mail(to: @user.email, subject: "You have #{activities.count} pending activities to complete!")
  end
end

