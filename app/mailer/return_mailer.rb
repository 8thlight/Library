class ReturnMailer < ActionMailer::Base
  default :from => "tak.yuki@gmail.com"

  def notify_book_available(user)
    mail(:to => user.email, :subject => "There is a book available for you!")
  end
end
