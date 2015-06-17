class MessagesController < ApplicationController

# -----------------------------------------------------------
#     C R E A T E
# -----------------------------------------------------------
  def create
    p params[:message]
    @event = Event.find(params[:event][:id])

    if params[:message][:text].empty?
      flash[:error] = t(:msg_create_err1)
    else
      @event.messages << Message.new(
        :text => params[:message][:text],
        :user_name => params[:message][:user_name])

      # write to history
      hist = History.new(:event_id => @event.id)
      hist.create_msg(params[:message][:text])
      @event.histories << hist

      flash[:notice] = t(:msg_create_succ)
    end
    redirect_to(:controller => :events, :action => :show, :id => @event.key)
  end
end
