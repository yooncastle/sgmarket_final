class HomeController < ApplicationController
  before_action :require_login, except: [:index]
  
  def index
      @posts=Post.all.page(params[:page]).per(12).order("created_at DESC")
  end
  
  def delete
    @del_post = Post.find(params[:post_id])
    @del_post.delete
    
    redirect_to "/home/index"
  end
  
  def delete_reply
    @del_reply = Reply.find(params[:reply_id])
    @del_reply.delete
    
    redirect_to :back
  end
  
  def update_view
    @upd_post = Post.find(params[:post_id])
  end

  def do_update
    
    @do_upd_post = Post.find(params[:post_id])
    
    @do_upd_post.title = params[:title]
    @do_upd_post.content = params[:content]
    @do_upd_post.contact = params[:contact]
    @do_upd_post.price = params[:price]
    @do_upd_post.user_id = current_user.id
  
    unless params[:avatars].nil?
    params[:avatars].each do |file|
        PostImage.create!(post_id: @do_upd_post.id, avatar: file)
      end
    end
    
    @do_upd_post.save
    
    redirect_to "/home/index"
  end
  
  def complete
    @new_post = Post.new
    
   # @new_post.avatars= params.permit({:avatars => []})

   # uploader = MktimageUploader.new
   # uploader.store!(file)
   # @new_post.image_url = uploader.url
    
    @new_post.title = params[:title]
    @new_post.content = params[:content]
    @new_post.contact = params[:contact]
    @new_post.user_id = current_user.id
    @new_post.price = params[:price]
    @new_post.save
    
    # create post_image
    if params[:avatars].nil?
      @new_post.image_url = "/assets/emptyimage.png"
      @new_post.save
    else
      params[:avatars].each do |file|
        PostImage.create!(post_id: @new_post.id, avatar: file)
      end
    end
    
    tag = Tag.find_or_create_by(name: params[:category])
    Hashtag.create(post_id: @new_post.id, tag_id: tag.id)
    
    tag = Tag.find_or_create_by(name: params[:hashtag1])
    Hashtag.create(post_id: @new_post.id, tag_id: tag.id)
    
    tag = Tag.find_or_create_by(name: params[:hashtag2])
    Hashtag.create(post_id: @new_post.id, tag_id: tag.id)
  
    tag = Tag.find_or_create_by(name: params[:hashtag3])
    Hashtag.create(post_id: @new_post.id, tag_id: tag.id)
    
    redirect_to "/home/index"
  end
 
  def view_each
    @one_post = Post.find(params[:post_id])
    if user_signed_in? && current_user==@one_post.user
      if @one_post.replies.count == 0
        @one_post.replycount=0
      else
        @one_post.replycount=@one_post.replies.last.id
      end
      @one_post.save
    end
  end
  
  def reply_write
    @new_reply = Reply.new
    @new_reply.content = params[:comment]
    @new_reply.post_id = params[:id_of_post]
    @new_reply.user_id = params[:user_id]
    @new_reply.save
    
    redirect_to :back
  end
  

  def myinfo
  end
  
  def show_user_post
    @myposts= current_user.posts.all.page(params[:page]).per(12).order("created_at DESC")
  end
  
  def show_reply_post
  end
  

  def tags
    tag = Tag.find_by(name: params[:name])
    @posts = tag.posts.all.page(params[:page]).per(12).order("created_at DESC")
  end
  
  
  def finish_post
    @fin_post=Post.find(params[:post_id])
    @fin_post.finished=1
    @fin_post.image_url="/assets/finished_pic.png"
    @fin_post.save
    
    redirect_to :back
  end
  
  def writer_post
    @nowpost=Post.find(params[:post_id])
    @writerpost=@nowpost.user.posts.all.page(params[:page]).per(12).order("created_at DESC")
  end
  
  def search
    if params[:search]
       @search = Post.search(params[:search]).all.page(params[:page]).per(12).order("created_at DESC")
    end
  end
    
end