class ReturnMailer < ActionMailer::Base
  default :from => "tak.yuki@gmail.com"

  def notify_book_available(user)
    @user = user
    mail(:to => "tak.yuki@gmail.com", :subject => "the book has been returned, it is waiting for you!")
  end
end
