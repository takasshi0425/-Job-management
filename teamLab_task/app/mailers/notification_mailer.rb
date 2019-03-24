class NotificationMailer < ApplicationMailer
  default from: "takasshi0425@gmail.com"

  def send_confirm(msg)
    @msg = msg
    mail(
      subject: '商品集計', #メールのタイトル,
      to: 'takasshi0425@gmail.com' #宛先
    ) do |format|
      format.text
    end
  end
end
