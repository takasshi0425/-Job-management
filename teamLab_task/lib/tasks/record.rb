require File.expand_path('../../../config/boot', __FILE__)
require File.expand_path('../../../config/environment', __FILE__)

require "date"

#重複したレコードの取得
dup_id = []
dup_id = UserLate.select('id').all     #users_lateの全id取得
dup_id = User.select('id').where(id: dup_id)   #重複idを取得
c=0

#削除されたレコードの集計
delete_data = []
delete_array = []
begin
  delete_data = UserLate.where.not(id: dup_id)
  delete_data.each do |del|
    delete = Deleted.new
    delete.delete_day = Date.today
    delete.id = del.id
    delete.name = del.name
    delete.exp = del.exp
    delete.price = del.price
    delete.save
  end
  Deleted.create(delete_array)
rescue => e
  @msg = "削除されたレコードの集計に失敗しました"
  NotificationMailer.send_confirm(@msg).deliver
  c=1
  puts e
end


#登録データの集計
insert_data = []
insert_array = []
begin
  insert_data = User.where.not(id: dup_id)
  insert_data.each do |ins|
     insert = Inserted.new
     insert.insert_day = Date.today
     insert.id = ins.id
     insert.name = ins.name
     insert.exp = ins.exp
     insert.price = ins.price
     insert.save
    #insert_array << Inserted.new(insert_day: Date.today, id: ins.id, name: ins.name, exp: ins.exp, price: ins.price)
  end
  #Inserted.create(insert_array)
rescue => e
  @msg = "登録されたレコードの集計に失敗しました"
  NotificationMailer.send_confirm(@msg).deliver
  puts e
  c=1
end

##users_lateにusersの全レコードを挿入
latest_data=[]
array = []
begin
  UserLate.delete_all()        #users_lateの全レコードを削除
  latest_data = User.all   #users_lateに挿入するための最新のレコードを取得
  latest_data.each do |data|  #users_lateに挿入
    late = UserLate.new
    late.id = data.id
    late.name = data.name
    late.exp = data.exp
    late.price = data.price
    late.save
  end
  UserLate.create(array)
rescue => e
  @msg = "直前のレコードの更新に失敗しました"
  NotificationMailer.send_confirm(@msg).deliver
  c=1
  puts e
end

#メール機能
if c==0 then
@msg = "集計に成功しました"
NotificationMailer.send_confirm(@msg).deliver
end
