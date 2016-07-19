# Articles Controller
class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all.order('date DESC')
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:notice] = "Article \"#{@article.title}\" successfully created"
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article \"#{@article.title}\" updated"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy

    flash[:notice] = "Article \"#{@article.title}\" successfully deleted"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.friendly.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :date, :text, :current, :image,
                                    :delete_image)
  end
end
