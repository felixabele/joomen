# encoding: utf-8
class HistoriesController < ApplicationController


  # --- INDEX
  # @params: event.id (key)
  def index
    @histories = History.find_all_by_event_id(params['id'], :order => 'created_at DESC')
  end

  # --- RSS
  # RSS Feed for Events
  # @params: event.key
  def rss
    @event = Event.find_by_key(params['id'])
    @histories = @event.histories(:order => 'created_at DESC')
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
end
