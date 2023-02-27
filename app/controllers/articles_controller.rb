class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  # identical name of template is expected at app/views/articles/another_index.html.erb ...
  def show
    @article = Article.find(params[:id])
  end
end
