class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret",
  except: [:index, :show]

  def index
    @articles = Article.all
  end
  
  # identical name of template is expected at app/views/articles/another_index.html.erb ...
  def show
    @article = Article.find(params[:id])
  end
  
  def new 
    # this `@article` is used in rendering for `new.html.erb`! This is then inputted in to form_with method of the overarching context. `form_with model: @article`.. then this is ""taken"" apart by do |form|, where form had the link to the `@article`. Then it knows to point to the model and the correct column in the model via the `form.label :title` - this is because the symbol name is the same to that of the migration's
    @article = Article.new
  end

  # but for some methods which are not mapped to a GET. These actions are not mapped to a view!
  def create 
    @article = Article.new(article_params)

    if @article.save # sees if successful!
      redirect_to @article
    else # if the new article is unsuccessful!
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    # this updates the 
    if @article.update(article_params)
      # this pulls up the model as it exists in the database
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # assuming I get a request 
  ## DELETE /articles/:id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy # what if this is unsuccessful?
    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    # appears to be mapping to `form.text_area :symbol`
    params.require(:article).permit(:title, :body, :status)
  end
end
