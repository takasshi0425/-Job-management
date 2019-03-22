require "#{Rails.root}/app/models/application_record"

module Record::Mn extend self
  protect_from_forgery with: :exception
  def total
    User.group("DATE(date)").count
  end
end
