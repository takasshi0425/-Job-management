require 'active_record'

ActiveRecord::Base.establish_connection(
   :adapter => 'mysql2',
   :host => 'localhost',
   :username => 'root',
   :password => '8hT9EiSytu7hP2aF',
   :database => 'product'
 )

 class User < ActiveRecord::Base

 end
