class BookDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def get_attr(attr)
    if REDIS.get("#{model.isbn}_#{attr}").nil?
      google_attribute = google_data(attr)
      add_to_redis(google_attribute, attr)
      "testing decorator"
    else
      REDIS.get("#{model.isbn}_#{attr}")
    end
  end

end
