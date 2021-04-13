class Users::CommentsController < ApplicationController

def create
  @post = Post.find(params[:post_id])
  @comment = Comment.new(comment_params)
  @comment.user_id = current_user.id
  @comment.post_id = @post.id
  @comment.save
  redirect_back(fallback_location: root_path)
end

def edit
  @post = Post.find(params[:post_id])
  @comment = Comment.find(params[:id])
end

def update
  @post = Post.find(params[:post_id])
  @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
  if @comment.update(comment_params)
    redirect_to post_path(@post.id)
  else
    render :show
  end
end

def destroy
  @post = Post.find(params[:post_id])
  @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
  @comment.destroy
  redirect_to post_path(@post.id)
end

private

def comment_params
  params.require(:comment).permit(:comment)
end
end
