module ApplicationHelper

  def active_class(link_path)
    active = current_page?(link_path) ? "active" : ""
  end

  def icon_check(active)
    icon = active ? "check" : "remove"
    content_tag(:i, class: "fa fa-#{icon}") do
      
    end
  end
end
