# ==============================================
#   All Static Pages are rendered here
# ==============================================
class StaticController < ApplicationController

  # --- I N D E X
  def index
    if !cookies['my_joomen'].nil?
      c_jm = cookies['my_joomen'].split(',')
      @my_joomen = Event.find_all_by_key(c_jm)
    end
  end

  # --- C h a n g e - L a n g u a g e
  def change_language
    #p params['language']
    if params['language'] == 'en'
      cookies['language'] = 'en'
    else
      cookies['language'] = 'de'
    end

    I18n.locale = params['language']
    #I18n.locale = params[:locale]
    redirect_to :back
  end

  # --- S T A R T
  def start

  end

  # --- I N F O R M A T I O N E N
  def information

  end

  # --- K O N T A K T
  def kontakt

  end

  # --- I M P R E S S U M
  def impressum

  end

  # --- F A Q
  def faq

  end

  # --- A B O U T
  def about

  end

  # --- F O R B I D D E N
  def forbidden

  end

end
