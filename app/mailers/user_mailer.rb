class UserMailer < ActionMailer::Base
  default :from => "sureshm@srishtisoft.com"
  def registration_confirmation(user)  
    mail(:to => user.email, :subject => "Registered", :from => "sureshm@srishtisoft.com")  
  end 
end
