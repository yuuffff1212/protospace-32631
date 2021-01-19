class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @prototypes = Prototype.includes(:user)
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
    unless current_user.id == @prototype.user
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if prototype.update(create_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if prototype.delete
      redirect_to root_path
    end
  end

  private
  def create_params
    params.require(:prototype).permit(:title, :concept, :catch_copy, :image).merge(user_id: current_user.id)
  end

end

#コントローラー、インスタンス変数に値をあげる方法
#ユーザーのログインによるアクセス範囲の制限
#before_actionの使用方法
#コントローラー内のアクション処理の記述
#form with model：の繋がりと記述方法
#データーベース作成時にカラム名の記述ミスに気をつけること
#繰り返し処理をする時に、collectionメソッドを部分テンプレート内で使用すること
#複数のツイートを表示するときには、N＋1問題の解決をすること
#N＋1問題には、indludesメソッドを使用すること、どこの処理で使用するのか理解しておくこと

