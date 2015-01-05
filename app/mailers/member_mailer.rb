# Members Mailer
class MemberMailer < ActionMailer::Base
  default from: 'caltaiko@gmail.com'

  def email_member(member)
    @member = member
    mail(to: @member.email, subject: 'Notice - Cal Raijin Taiko')
  end
end
