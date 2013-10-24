class LoginController < ApplicationController
  def index
    redirect_to :action=> 'login'
  end
  def login
    render :laout => false
  end
  def load_login_page
    
  end
  def uploadFile_mail_to_patient
   #raise  params[:mail_detail][:to_mail].inspect
   UserMailer.registration_confirmation(params[:mail_detail])
   # mail(:from => "YashomatiHospital", :to => params[:mail_detail][:to_mail], :subject => params[:mail_detail][:subject])
  end
end
