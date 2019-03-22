require "application_record.rb"
require 'clockwork'
include Clockwork

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def total
    @user = User.group("DATE(date)").count
  end
end
