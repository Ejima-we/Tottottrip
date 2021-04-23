class Users::CommentsController < ApplicationController
  
  before_action :authenticate_user
  
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @comment.save
    render :index
  end
  
  # def edit
  #   @post = Post.find(params[:post_id])
  #   @comment = Comment.find(params[:id])
  # end
  
  # def update
  #   @post = Post.find(params[:post_id])
  #   @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
  #   if @comment.update(comment_params)
  #     redirect_to post_path(@post.id)
  #   else
  #     render :show
  #   end
  # end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    render :index
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
