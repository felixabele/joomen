ActionMailer::Base.smtp_settings = {
  :address              => "localhost",
  :port                 => 25,
  :domain               => "joomen.de",
  :user_name            => "info",
  :password             => "poor*karin",
  :authentication       => "plain",
  :enable_starttls_auto => false
}