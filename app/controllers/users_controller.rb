# encoding: utf-8
class UsersController < ApplicationController

# -----------------------------------------------------------
#     C R E A T E
# -----------------------------------------------------------
  def create

    @event = Event.find(params[:event][:id])

    # Save
    if params[:user]
      user = User.new(params[:user])
      user.event = @event;

      if user.save

        # write to history
        hist = History.new(:user_id => user.id)
        hist.create_user(user.name)
        @event.histories << hist

        flash[:notice] = t(:users_create_succ)
        redirect_to(:controller => :events, :action => :show, :id => @event.key)
      else
        render(:action => :create)
      end

    end
  end

# -----------------------------------------------------------
#     E D I T
# -----------------------------------------------------------
  def edit
    user = User.find(params[:id])
  end

# -----------------------------------------------------------
#     D E S T R O Y
# -----------------------------------------------------------
  def destroy
    user = User.find(params[:id])
    unless user.nil?
      event = user.event
      user.destroy
      redirect_to(:controller => :events, :action => :show, :id => event.key)
    else 
      redirect_to(:back)
    end
  end
end
