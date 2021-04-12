class Users::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all.order(create_at: :desc)
    @posts = @posts_all.page(params[:page]).per(10)
  end

  def rank
    @all_ranks = Post.find(Favorite.group(:post_id).order("count(post_id)desc").limit(3).pluck(:post_id))
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user.id)
    @comment = Comment.new
    @comments_all = Comment.all
    @tags = @post.tag_counts_on(:tags)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def tag
    # タグをPostモデルから降順で取得
    @tags = Post.tag_counts_on(:tags).order(created_at: :desc)
    if @tag = params[:tag]
      # タグに紐付く投稿 　tagged_with 絞り込み検索するメソッド
      @post = Post.tagged_with(params[:tag])
    end
  end

  def search
    selection = params[:keyword]
    @posts = Post.sort(selection)
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :body, :image, :price, :address, :tag_list)
  end
end
