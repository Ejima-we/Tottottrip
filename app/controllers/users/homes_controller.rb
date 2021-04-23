class Users::HomesController < ApplicationController

  before_action :authenticate_user, only: [:mail, :done]
  before_action :authenticate_guest_user, only: [:mail, :done]

  def top
    @genres = Genre.all
    @posts_rank = Post.find(Favorite.group(:post_id).order("count(post_id)desc").limit(9).pluck(:post_id))
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(9)
  end

  def inquiries
    @inquiry = Inquiry.new
  end

  def mail
    inquiry = Inquiry.new(inquiry_params)
    if user_signed_in?
      if current_user.name != "guest5gbcyjsozzkdyyb6"
        inquiry.email = current_user.email
      end
    end
    InquiryMailer.send_mail(inquiry).deliver_now
    redirect_to done_path
  end

  def done
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :message)
  end
end
