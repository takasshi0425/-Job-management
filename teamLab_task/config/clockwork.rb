require 'clockwork'

require File.expand_path('../boot', __FILE__)
require File.expand_path('../environment', __FILE__)

module Clockwork

handler do |job|
  p "#{job}: user count => #{User.count}"
end

every(1.minute, 'minute')
end
