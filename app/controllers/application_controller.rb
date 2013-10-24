require 'skip.rb'
class ApplicationController < ActionController::Base
 filter_parameter_logging "last_name"
 # protect_from_forgery
 # before_filter :initialize_ambient
  #before_filter :set_configuration
  #layout 'application'
 def before_login
      flash[:notice] = "Please log in "
      redirect_to(:controller => "/login", :action => "login")
 end
 def initialize_ambient
    Ambient.init()
 end
  
  ## Loading configurable points for partcular location
  def set_configuration
     Ambient.init()
    raise Ambient.init().inspect
    #default_conf = ConfWithCaching.create_conf(FileConf, nil, "sr_conf/default_conf.rb")
    #Ambient.conf = ConfWithCaching.create_conf(FileConf, nil, "sr_conf/default_conf.rb")
  end
end
