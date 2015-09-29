module ApplicationHelper
  def navbar_link(controller)
    params[:controller] == controller ? 'active' : ''
  end

  def checked(category)
   @check = false
   @article.categories.all.each do |c|
      if c[:id]==category[:id]
        @check |= true
      else
        @check |= false
      end
    end
    return @check
  end
end
