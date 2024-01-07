class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy, :update]
  
  def index
    articles = Article.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded articles', data: articles }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the article', data: @article }
  end

  def create
    article = Article.new(article_params)
    if article.save
      render json: { status: 'SUCCESS', data: article }
    else
      render json: {status: 'ERROR',  data: article.errors }
    end
  end

  def destroy
    if @article.destroy
      render json: { status: 'SUCCESS', message: 'Deleted the article', data: @article }
    else
      render json: { status: 'ERROR', message: 'Error deleting the article' }
    end
  end

  def update
    if @article.update(article_params)
      render json: { status: 'SUCCESS', message: 'Updated the article', data: @article }
    else
      render json: { status: 'ERROR', message: 'Not updated', data: @article.errors }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end
end
