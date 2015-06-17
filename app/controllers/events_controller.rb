# encoding: utf-8
class EventsController < ApplicationController
  before_filter :admins_only, :only => [:index, :destroy]
  layout :choose_layout

  def choose_layout
    if ['print'].include?(action_name)
      'print'
    else
      'application'
    end
  end

# -----------------------------------------------------------
#     I N D E X
# -----------------------------------------------------------
  def index
    @events = Event.find(:all)    
  end

# -----------------------------------------------------------
#     S H O W
# -----------------------------------------------------------
  def show
    @event = Event.find_by_key(params[:id])
    key = @event.key

    # Get all Stored Joomen as Array
    unless cookies['my_joomen'].nil?
      cookie_store = cookies['my_joomen'].split(',')
      cookie_store.push(key)
    else
      cookie_store = [key]
    end

    # Create new Cookie including current joomen
    cookies['my_joomen'] = cookie_store.uniq.join(',')

    # is a password required ?
    unless @event.password.nil? or @event.password.empty?

      if (session['open_joomen'] != key)

        # Validate Password
        if (params[:event].nil?) || (@event.password != params[:event][:password])

          if params[:event].nil? || params[:event][:password].nil?
            flash[:notice] = "Bitte geben Sie ein Passwort für dieses Joomen an"
          else
            flash[:error] = "Ihr Passwort scheint nicht korrekt zu sein"
          end
          # goto Passwort Input-Form
          render(:action => :password)

        # Password Correct => create Session
        else
          session['open_joomen'] = key
        end
      end
    end

    flash[:notice] = ''
    flash[:error] = ''
  end

# -----------------------------------------------------------
#     P R I N T
# -----------------------------------------------------------
  def print
    @event = Event.find_by_key(params[:id])
  end

# -----------------------------------------------------------
#     E D I T
# -----------------------------------------------------------
  def edit

    @event = Event.find(params[:id])

    # Edit
    if params[:event]
      if @event.update_attributes(params[:event])
        flash[:notice] = t(:events_edit_succ)
        redirect_to(:action => :index)
      else
        render(:action => :edit)
      end

    end
  end

# -----------------------------------------------------------
#     C R E A T E
# -----------------------------------------------------------
  def create

    # Save
    if params[:event]
      event = Event.new(params[:event])
      event.key = Event.random_key

      if event.save

        # Send Out Password for this event by EMail
        if (event.email != '') && (event.password != '')
          EventsMailer.event_password(event).deliver
        end

        # write to history
        hist = History.new
        hist.create_jmn(event.name)
        event.histories << hist

        flash[:notice] = t(:events_create_succ)
        redirect_to(:action => :show, :id => event.key)
      else
        render(:action => :create)
        flash[:error] = t(:events_create_err1)
      end

    end

    # Render Layout + View
    #respond_to do |format|
    #  format.html { render(:action => :create) }
    #  format.js   { render(:action => :create, :layout => "ajax_load") }
    #end
  end

# -----------------------------------------------------------
#     P A S S W O R D
# -----------------------------------------------------------
  def password

  end


# -----------------------------------------------------------
#     D E S T R O Y
# -----------------------------------------------------------
  def destroy    
    event = Event.find(params[:id])
    
    if event.destroy
      flash[:notice] = t(:events_destroy_succ)
      redirect_to(:action => :index)
    end

  else
    redirect_to(:controller => :static, :action => :forbidden)
  end  
end
