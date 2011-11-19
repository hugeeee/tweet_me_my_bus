module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "Tweet Me My Bus"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("logo.png", :alt => "Tweet Me My Bus App", :class => "round")
  end
end
