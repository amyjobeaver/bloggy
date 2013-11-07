class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
   @tags = Tag.select(:title).uniq 

    if params[:title].blank?
     @blogs = Blog.order('id desc')
     else
     tags = Tag.where(:title => params[:title])
   
      @blogs = []
      tags.each do |tag|
       parent_blog = tag.blog
        @blogs.push(parent_blog)
     end
  end

   # @tags = Tag.all
    #if ! params[:tag_id].blank?
     # t = Tag.find(params[:tag_id])
      #tags = Tag.where(:title => t.title)
      #@blogs = []
      #tags.each do |tag|
       # parent_blog = tag.blog
        #@blogs.push(parent_blog)
      #end
   # else
    #@blogs = Blog.all

  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @comments = @blog.comments
    Rails.logger.info @comments.inspect
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
    @tag = Tag.new
    @tag.blog_id = @blog.id
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render action: 'show', status: :created, location: @blog }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :content)
    end
end
