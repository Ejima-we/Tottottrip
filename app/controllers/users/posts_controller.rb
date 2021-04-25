class Users::PostsController < ApplicationController

  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_guest_user, only: [:new, :create, :edit, :update, :destroy]

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
    @tags = Post.tags_on(:tags)
    @q = Post.ransack(params[:q])
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @no_genres = Genre.where.not(id: @genre.id)
      @posts_all = Post.where(genre_id: @genre.id).order(created_at: "DESC").page(params[:page]).per(18)
    else
      @posts = @q.result(distinct: true)
      @posts_all = @posts.order(created_at: "DESC").page(params[:page]).per(18)
    end
  end

  def rank
    @genres = Genre.all
    @q = Post.ransack(params[:q])
    @tags = Post.tags_on(:tags)
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @no_genres = Genre.where.not(id: @genre.id)
      @posts = Favorite.joins(:post).where(posts: {genre_id: params[:genre_id]}).group(:post_id).order("count(post_id) desc").limit(15).pluck(:post_id)
      @all_ranks = Post.find(@posts)
    else
      @all_ranks = Post.find(Favorite.group(:post_id).order("count(post_id)desc").limit(15).pluck(:post_id))
    end
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
    @q = Post.ransack(params[:q])
    # タグをPostモデルから降順で取得
    @tags = Post.tag_counts_on(:tags).order(created_at: :desc)
    if @tag = params[:tag]
      # タグに紐付く投稿 　tagged_with 絞り込み検索するメソッド
      @tags_all = Post.tags_on(:tags)
      @posts = Post.tagged_with(params[:tag])
      @posts_all = @posts.order(created_at: "DESC").page(params[:page]).per(20)
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :body, :price, :address, :tag_list, post_images_images:[])
  end

end
