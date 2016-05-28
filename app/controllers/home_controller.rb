class HomeController < ApplicationController
  def index
    @posts = Post.all
  end
  
  def write
    @new_post = Post.new
    @new_post.title = params[:title]
    @new_post.content = params[:content]
    @new_post.save
  end
  
 
  
end