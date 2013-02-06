module ApplicationHelper
  def is_on_production?
    return Rails.env.production?
  end
end
