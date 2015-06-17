class Item < ActiveRecord::Base
  attr_accessible :event_id, :name


  # Relations
  belongs_to :event
  belongs_to :user
  has_many   :histories

  # Validation
  validates_presence_of :name, :message => "Bitte Name eingeben"

end
