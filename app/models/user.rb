class User < ActiveRecord::Base
  attr_accessible :event_id, :name

  # Relations
  belongs_to  :event
  has_many    :items
  has_many    :histories
end
