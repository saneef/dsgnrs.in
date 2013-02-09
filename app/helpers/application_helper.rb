module ApplicationHelper
  def on_production?
    return Rails.env.production?
  end
end
