require "bundler"
Bundler.require

require 'clockwork'
include Clockwork

require File.expand_path('../boot', __FILE__)
require File.expand_path('../environment', __FILE__)

#重複したデータの取得

every(1.day,'updating',:at => '16:11') do
    #Dir.chdir("config/"){puts `ruby products_update.rb`}
    Dir.chdir("lib/tasks"){puts `ruby record.rb`}
end
