module ApplicationHelper
  def navbar_link(controller)
    params[:controller] == controller ? 'active' : ''
  end
end
