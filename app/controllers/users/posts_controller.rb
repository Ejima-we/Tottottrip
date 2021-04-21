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
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @q = Post.ransack(params[:q])
      @posts_all = @genre.posts.order(created_at: "DESC").page(params[:page]).per(20)
    else
      @q = Post.ransack(params[:q])
      @posts = @q.result(distinct: true)
      @posts_all = @posts.order(created_at: "DESC").page(params[:page]).per(20)
    end
  end

  def rank
    @genres = Genre.all
    if params[:genre_id]
      @posts = Favorite.joins(:post).where(posts: {genre_id: params[:genre_id]}).group(:post_id).order("count(post_id) desc").limit(10).pluck(:post_id)
      @all_ranks = Post.find(@posts)
    else
      @all_ranks = Post.find(Favorite.group(:post_id).order("count(post_id)desc").limit(10).pluck(:post_id))
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
    # タグをPostモデルから降順で取得
    @tags = Post.tag_counts_on(:tags).order(created_at: :desc)
    if @tag = params[:tag]
      # タグに紐付く投稿 　tagged_with 絞り込み検索するメソッド
      @posts = Post.tagged_with(params[:tag])
      @posts_all = @posts.order(created_at: "DESC").page(params[:page]).per(1)
    end
  end

  # def tag_search
  #   selection = params[:keyword]
  #   @posts = Post.sort(selection)
  # end

  def genre_search

  end

  private

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :body, :image, :price, :address, :tag_list)
  end

end
