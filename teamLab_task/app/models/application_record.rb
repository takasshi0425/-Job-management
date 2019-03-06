require 'active_record'

ActiveRecord::Base.establish_connection(
   :adapter => 'mysql2',
   :host => 'localhost',
   :username => 'root',
   :password => 'iTdBhF08SBslOjU1',
   :database => 'product'
 )

 class User < ActiveRecord::Base

 end
