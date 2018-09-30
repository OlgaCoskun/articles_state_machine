class CommentsController < ApplicationController

  before_action :set_post, only: [:create, :destroy, :like]
  before_action :set_comment, only: [:destroy, :like]

  def create
    @new_comment = @post.comments.build(comment_params)

    if @new_comment.save
      redirect_to @post, notice: 'Your comment was created'
    else
      render 'posts/show', alert: 'It is wrong!'
    end
  end

  def destroy
    message = { notice: 'Comment was deleted' }
    @comment.destroy
    redirect_to @post, message
  end

  def like
    @comment.increment!(:like_count)
    redirect_to @post
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:com_body, :user_name)
  end

end
