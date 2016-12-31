class CommentsController < ApplicationController
  before_action :set_comment, only: :destroy

  # WIP
  def create
    klass = "Comments::#{safe_klass}Service".safe_constantize
    klass.new(params: comment_params).create

    render nothing: true
  end

  def destroy
    klass = "Comments::#{safe_klass}Service".safe_constantize
    klass.new(comment: @comment).delete

    render nothing: true
  end

  private

  def safe_klass
    klass = params.fetch(:comment_type, 'base')

    raise ArgumentError unless %w(strategy meeting moment base).include?(klass)

    klass.camelize
  end

  def set_comment
    @comment = Comment.find(params[:id])
  rescue
    respond_to_nothing if @comment.blank?
  end

  def comment_params
    params.require(:comment).permit(:comment_type, :commented_on, :comment_by,
                                    :comment, :visibility, :viewers)
  end
end
