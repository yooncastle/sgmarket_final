class HomeController < ApplicationController
  def index
    @posts = Post.all.reverse
  end
  
  def delete
    @del_post = Post.find(params[:post_id])
    @del_post.delete
    
    redirect_to "/home/index"
  end
  
  def update_view
    @upd_post = Post.find(params[:post_id])
  end

  def do_update
    @do_upd_post = Post.find(params[:post_id])
    @do_upd_post.title = params[:title]
    @do_upd_post.content = params[:content]
    @do_upd_post.save
    
    redirect_to "/home/index"
  end
  
  def complete
    @new_post = Post.new
    @new_post.title = params[:title]
    @new_post.content = params[:content]
    @new_post.save
    redirect_to "/home/index"
  
  end
 
  
end