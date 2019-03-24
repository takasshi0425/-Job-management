
require "bundler"
Bundler.require

require_relative 'clockwork'
include Clockwork

require File.expand_path('../boot', __FILE__)
require File.expand_path('../environment', __FILE__)

#重複したデータの取得

every(1.day,'updating',:at => '02:01') do
    Dir.chdir("lib/tasks"){puts `ruby record.rb`}
end
