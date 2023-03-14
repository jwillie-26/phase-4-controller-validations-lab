class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    posts = Post.all
    render json: posts
  end

  def show
    post = Post.find(params[:id])

    render json: post
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    render json: post
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  def create
    post = Post.create(post_params)
    render json: post
  end

  private

  def render_not_found_response
    render json: { error: "Post not Found" }, status: :not_found
  end

  def post_params
    params.permit(:category, :content, :title)
  end

end
