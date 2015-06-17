class Event < ActiveRecord::Base
  attr_accessible :key, :name, :password, :email


  # Relations
  has_many :items,      :dependent => :destroy
  has_many :users,      :dependent => :destroy
  has_many :messages,   :dependent => :destroy
  has_many :histories,  :dependent => :destroy

  # Validation
  validates_presence_of :name, :message => "Bitte Name eingeben"

  # -----------------------------------------------------------
  #     NICHT ZUGEORDNETE ITEMS
  # -----------------------------------------------------------
  def free_items
    self.items.find(:all, :conditions => "user_id IS NULL OR user_id = ''")
  end

  # -----------------------------------------------------------
  #     Random Key
  # -----------------------------------------------------------
  def self.random_key
    key           = ((Time.now).yday).to_s
    key_range     = ('a'..'z').to_a
    key_range.concat(('0'..'9').to_a)
    range_length  = key_range.length
    key_length    = 10

    key_length.times do
        key << key_range[rand(range_length)]
    end
    key
  end

end
