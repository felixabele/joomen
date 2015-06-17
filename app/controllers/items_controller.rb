# encoding: utf-8
class ItemsController < ApplicationController


# -----------------------------------------------------------
#     L I S T
# -----------------------------------------------------------
  # --- List Items by User
  def list
    @items = Item.find_all_by_user_id(params[:id])
  end


# -----------------------------------------------------------
#     C R E A T E
# -----------------------------------------------------------
  def create
    e_id = (params[:id] or params[:event][:id])
    @event = Event.find(e_id)

    # Save
    if params[:item]
      
      # if multiple items create more of them
      params[:item][:count].to_i.times do |c|      
        item = Item.new()
        item.name = params[:item][:name]
        item.event = @event;
            
        if item.save

          # write to history
          hist = History.new(:item_id => item.id)
          hist.create_item(item.name)
          @event.histories << hist

          flash[:notice] = t(:items_create_succ)        
        else
          flash[:error] = t(:items_create_err1)
        end
      end
      redirect_to(:controller => :events, :action => :show, :id => @event.key)
    else
      # Render Layout + View
      respond_to do |format|
        format.html { render(:action => :create) }
        format.js   { render(:action => :create, :layout => "ajax_load") }
      end
    end
  end


# -----------------------------------------------------------
#     A S S I G N - T O - U S E R
# -----------------------------------------------------------
  def assign_user
    item = Item.find(params[:id])
    @event = item.event

    item.user_id = params[:user_id]
    if item.save

      # write to history
      hist = History.new(:item_id => item.id, :user_id => item.user_id)
      hist.assign_item(item.name, item.user.name)
      @event.histories << hist

      respond_to do |format|
        format.html {
          flash[:notice] = t(:items_assign_usr_succ)
          redirect_to(:controller => :events, :action => :show, :id => @event.key) }
        format.js {
          render :text => 'true' }
      end

    else
      respond_to do |format|
        format.html {
          flash[:error] = t(:items_assign_usr_err1)
          render(:controller => :events, :action => :show, :id => @event.key) }
        format.js {
          render :text => 'false' }
      end
    end
  end

# -----------------------------------------------------------
#     S E T - F R E E (Unassign User)
# -----------------------------------------------------------
  def set_free
    item = Item.find(params[:id])
    @event = item.event
    from_user_id = item.user_id
    from_user_name = item.user.name unless item.user.nil?

    item.user_id = ''
    if item.save

        # write to history
        hist = History.new(:item_id => item.id, :user_id => from_user_id)
        hist.unassign_item(item.name, from_user_name)
        @event.histories << hist

        respond_to do |format|
          format.html {
            flash[:notice] = t(:items_set_free_succ)
            redirect_to(:controller => :events, :action => :show, :id => @event.key) }
          format.js {
            render :text => 'true' }
        end
    else
      respond_to do |format|
        format.html {
          flash[:error] = t(:items_set_free_err1)
          render(:controller => :events, :action => :show, :id => @event.key) }
        format.js {
          render :text => 'false'  }
      end
    end
  end


# -----------------------------------------------------------
#     D E S T R O Y
# -----------------------------------------------------------
  def destroy
    item = Item.find(params[:id])
    event_key = item.event.key

    item_id   = item.id
    event_id  = item.event_id
    item_name = item.name

    if item.destroy

      # write to history
      hist = History.new(:item_id => item_id, :event_id => event_id)
      hist.delete_item(item_name)
      hist.save

      flash[:notice] = t(:items_destroy_succ)
      redirect_to(:controller => :events, :action => :show, :id => event_key)
    end
  end

end
