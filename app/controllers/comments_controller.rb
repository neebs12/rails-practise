class CommentsController < ApplicationController
  def create
    # see that in the bin/rails routes that the route now has `:article_id` mapped to it!
    @article = Article.find(params[:article_id])
    # see that we now have this as .comments.create where `comments` is available due to model association!
    # note that `@comment` instance variable was declared here but not used in subseq code
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
