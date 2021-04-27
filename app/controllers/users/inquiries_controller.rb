class Users::InquiriesController < ApplicationController
  before_action :authenticate_user, only: %i[mail done]
  before_action :authenticate_guest_user, only: %i[mail done]

  def inquiries
    @inquiry = Inquiry.new
  end

  def mail
    inquiry = Inquiry.new(inquiry_params)
    if (inquiry.name != '') && (inquiry.message != '')
      inquiry.email = current_user.email if user_signed_in? && (current_user.name != 'guest5gbcyjsozzkdyyb6')
      InquiryMailer.send_mail(inquiry).deliver_now
      redirect_to done_path
    else
      render :inquiries
    end
  end

  def done; end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :message)
  end
end
