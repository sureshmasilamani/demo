    ActionMailer::Base.smtp_settings = { 
      # :address => "192.168.1.1",
      # :port => 25,
      # :domain => "sarvgya.srishti",
    :tls => true,
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "YOURDOMAIN",
    :authentication => :plain,
    :user_name => "sureshmasilamani85@gmail.com",
    :password => "vengaivengai"
    } 