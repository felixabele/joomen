# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # -----------------------------------------------------------
  #     DATE
  # -----------------------------------------------------------
  # --- returns the date in a better formatting
  def german_format(date)
    date.strftime("%d.%m.%y")
  end

  # --- returns the date/time in a better formatting
  def german_time_format(date)
    date.strftime("%d.%m.%y - %H:%M")
  end

  def en_format(date)
    date.strftime("%m.%d.%y")
  end

  # --- returns the date/time in a better formatting
  def en_time_format(date)
    date.strftime("%m.%d.%y - %H:%M")
  end

  # -----------------------------------------------------------
  #     SELECT OPTIONS
  # -----------------------------------------------------------
  def select_options(subjects, first, second, selected='')
    html_options = ""
    subjects.each { |subject|
      if subject[first] == selected
        sel = 'selected'
      end
      html_options << "<option value='#{subject[first]}' #{sel}>#{subject[second]}</option>"
    }
    html_options.html_safe
  end

  # -----------------------------------------------------------
  #     Rounded Cornered Box
  # -----------------------------------------------------------
  def start_roundedBox(width)
    html = "
      <div class='b_ol'></div>
      <div class='b_om' style='width: #{width}px'></div>
      <div class='b_or'></div>
      <div class='b_body' style='width: #{width-8}px'>"
    html.html_safe
  end

  def end_roundedBox(width)
    html = "
      </div>
      <div class='b_ul'></div>
      <div class='b_um' style='width: #{width}px'></div>
      <div class='b_ur'></div>
      <br clear='all' />"
    html.html_safe
  end

  # -----------------------------------------------------------
  #     Customized Submit-Button
  # -----------------------------------------------------------
  def cust_submit(form_id, label)
    html = "
    <div class='btn' onclick=\"$('\#"+ form_id +"').submit()\">
      <div class='btn_left'></div>
      <div class='btn_middle'>#{label}</div>
      <div class='btn_right'></div>
    </div>
    <br clear='all' />"
    html.html_safe
  end



end
