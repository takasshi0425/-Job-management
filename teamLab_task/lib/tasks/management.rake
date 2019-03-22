namespace :record do
  desc "レコードを集計するタスク"
 task management: :environment do
   Record::Mn.total
 end
end
