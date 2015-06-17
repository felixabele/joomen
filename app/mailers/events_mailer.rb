# encoding: UTF-8
class EventsMailer < ActionMailer::Base
  default from: "info@joomen.de"

  def event_password(event)
    @event = event
    mail(:to => "#{event.email}", :subject => "Passwort fuer Joomen '#{event.name}'")
  end
end
