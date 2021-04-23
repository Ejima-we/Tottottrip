class Users::InquiriesController < ApplicationController

  before_action :authenticate_user, only: [:mail, :done]
  before_action :authenticate_guest_user, only: [:mail, :done]

  def inquiries
    @inquiry = Inquiry.new
  end

  def mail
    inquiry = Inquiry.new(inquiry_params)
    if (inquiry.name != "") && (inquiry.message != "")
      if user_signed_in?
        if current_user.name != "guest5gbcyjsozzkdyyb6"
          inquiry.email = current_user.email
        end
      end
      InquiryMailer.send_mail(inquiry).deliver_now
      redirect_to done_path
    else
      render :inquiries
    end
  end

  def done
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :message)
  end

end
