class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:new, :edit, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype =  Prototype.new 
  end

  def create
    @prototype = Prototype.new(create_params)
    if @prototype.save
      redirect_to root_path
    else
      render  :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless user_signed_id?
      redirect_to action: :index
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(create_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.delete
      redirect_to root_path
    end
  end

  private
  def create_params
    params.require(:prototype).permit(:title, :concept, :catch_copy, :image).merge(user_id: current_user.id)
  end
end
