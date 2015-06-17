class Message < ActiveRecord::Base
  attr_accessible :event_id, :text, :user_name


  # Relations
  belongs_to  :event
end
