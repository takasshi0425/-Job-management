require File.expand_path('../../../config/boot', __FILE__)
require File.expand_path('../../../config/environment', __FILE__)

require "date"

#重複したデータの取得
dup_id = []
dup_id = Latest.select('id').all     #latest_proの全id取得
dup_id = Product.select('id').where(id: dup_id)   #重複idを取得

#削除データの集計
delete_data = []
d_array = []
begin
    delete_data = Latest.where.not(id: dup_id)
    delete_data.each do |d_data|
        d_array << Deleted.new(delete_day: Date.today, id: d_data.id, name: d_data.name, exp: d_data.exp, price: d_data.price)
    end
    Deleted.import(d_array)
rescue => e
@msg = "削除データの集計に失敗しました"
NotificationMailer.send_confirm(@testdata).deliver
end


#登録データの集計
insert_data = []
i_array = []
begin
    insert_data = Product.where.not(id: dup_id)
    insert_data.each do |i_data|
        i_array << Inserted.new(insert_day: Date.today, id: i_data.id, name: i_data.name, exp: i_data.exp, price: i_data.price)
    end
    Inserted.import(i_array)
rescue => e
    @msg = "登録データの集計に失敗しました"
    NotificationMailer.send_confirm(@testdata).deliver
end

##latest_proに最新のdbの状態をコピー（全レコードを挿入）
array = []
begin
    Latest.destroy_all()        #latest_proの全レコードを削除
    latest_data = Product.all   #latest_proに挿入するための最新のレコードを取得
    latest_data.each do |data|  #latest_proに挿入
        array << Latest.new(id: data.id,name: data.name,exp: data.exp,price: data.price)
    end
    Latest.import(array)
rescue => e
    @msg = "latest_proの更新に失敗しました"
    NotificationMailer.send_confirm(@testdata).deliver
end

#メール機能
@testdata = "成功しました"
NotificationMailer.send_confirm(@testdata).deliver
