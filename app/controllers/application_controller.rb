class ApplicationController < ActionController::Base  
  USER, PASSWORD = 'admin', 'guardian'
  
  before_filter :set_locale
  protect_from_forgery

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    if !params[:language].nil?
      I18n.locale = params[:language]
    elsif cookies[:language]
      I18n.locale = cookies[:language]
    elsif !request.env['HTTP_ACCEPT_LANGUAGE'].nil?
      I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
  end
  
  # --- Verify Crendentials 
  private
    def admins_only
      authenticated = authenticate_or_request_with_http_basic do |user, password|
        user == USER && password == PASSWORD
      end
      
      if !authenticated
        redirect_to(:controller => :static, :action => :forbidden)
      end
  end

end
