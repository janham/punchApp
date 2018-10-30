class DisplaydatesController < ApplicationController

  # date_selectフォームで入力されたデータを受け取る
  def update
    @displaydate = Displaydate.find_by(id:1)
    @displaydate.list_date = Time.zone.local(params[:displaydate]["list_date(1i)"].to_i,
                                             params[:displaydate]["list_date(2i)"].to_i,
                                             params[:displaydate]["list_date(3i)"].to_i)
    @displaydate.save
    redirect_to '/punches'
  end
end