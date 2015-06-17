# encoding: utf-8
class History < ActiveRecord::Base
  attr_accessible :action, :event_id, :item_id, :user_id

  # Relations
  belongs_to  :event
  belongs_to  :user
  belongs_to  :item

  # Alle möglichen Aktionen
  # - create joomen
  # - create, delete item
  # - assign, unassign item
  # - create, delete teilnehmer
  # - create message
#I18n.locale

  # --- neues Joomen
  def create_jmn(name)
    if :locale == 'de'
      self.action = "Joomen '#{name}' wurde erstellt"
    else
      self.action = "Joomen '#{name}' has been created"
    end
  end

  # -----------------------------------------------------------
  #     I T E M S
  # -----------------------------------------------------------
  # --- neues Item
  def create_item(name)
    if :locale == 'de'
      self.action = "Aufgabe '#{name}' wurde erstellt"
    else
      self.action = "Task '#{name}' has been created"
    end
  end

  # --- Aufgabe löschen
  def delete_item(name)
    if :locale == 'de'
      self.action = "Aufgabe '#{name}' wurde gelöscht"
    else
      self.action = "Task '#{name}' has been deleted"
    end
  end

  # --- Aufgabe zuweisen
  def assign_item(item_name, user_name)
    if :locale == 'de'
      self.action = "Aufgabe '#{item_name}' wurde dem Teilnehmer '#{user_name}' zugeteilt"
    else
      self.action = "Task '#{item_name}' has been assigned to '#{user_name}'"
    end
  end

  # --- Aufgabe freistellen
  def unassign_item(item_name, user_name)
    if :locale == 'de'
      self.action = "Aufgabe '#{item_name}' ist nicht mehr dem Teilnehmer '#{user_name}' zugeteilt"
    else
      self.action = "Task '#{item_name}' is no longer assigned to '#{user_name}'"
    end
  end

  # -----------------------------------------------------------
  #     U S E R
  # -----------------------------------------------------------
  # --- Teilnehmer erstellen
  def create_user(user_name)
    if :locale == 'de'
      self.action = "Teilnehmer '#{user_name}' wurde angelegt"
    else
      self.action = "'#{user_name}' joined"
    end
  end

  # --- Teilnehmer löschen
  def delete_user(user_name)
    if :locale == 'de'
      self.action = "Teilnehmer '#{user_name}' wurde entfernt"
    else
      self.action = "Attendee '#{user_name}' has been removed"
    end
  end

  # -----------------------------------------------------------
  #     M E S S A G E S
  # -----------------------------------------------------------
  # --- Nachricht erstellen
  def create_msg(txt)
    if :locale == 'de'
      self.action = "Nachricht: '#{txt}'"
    else
      self.action = "Message: '#{txt}'"
    end
  end
end
