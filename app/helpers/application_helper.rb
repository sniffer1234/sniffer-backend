module ApplicationHelper

  def active_class(link_path)
    active = current_page?(link_path) ? "active" : ""
  end

  def icon_check(active)
    icon = active ? "check" : "remove"
    content_tag(:i, class: "fa fa-#{icon}") do

    end
  end

  def filter_link_class(params, order_by_attr, order_by_asc)
    if params[:order_by_attr] && params[:order_by_asc]
      if params[:order_by_attr] == order_by_attr && params[:order_by_asc] == order_by_asc
        return 'active'
      end
    end
  end
end
