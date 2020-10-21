class CommentsController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else 
      render "prototypes/show"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text, :prototype_id).merge(user_id: current_user.id)
    end
end
