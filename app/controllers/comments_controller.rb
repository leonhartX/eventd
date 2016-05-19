class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_back fallback_location: root_path, flash: { success: 'Comment was posted.' }
    else
      redirect_back fallback_location: root_path, flash: { danger: 'Comment failed to post.' }
    end
  end

  def destroy
    @comment.destroy
    redirect_back fallback_location: root_path, flash: { success: 'comment deleted.'}
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :event_id)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_path if @comment.nil?
  end
end
