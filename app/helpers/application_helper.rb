module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Stashboard"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def powered_by
    image_tag "poweredbystash.png"
  end
  
  def logo
    image_tag "logo.png", id: "logo"
  end
  
  def icon_for(status)
    
    icon_for = {
                   up: "icons/fugue/tick-circle.png",
                   warning: "icons/fugue/exclamation.png",
                   maintenance: "icons/fugue/clock.png",
                   down: "icons/fugue/cross-circle.png" }
    
    return image_tag icon_for[status]
  
  end

  
end