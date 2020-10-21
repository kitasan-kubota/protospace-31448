class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_prototype, only: %i[show edit destroy update]
  before_action :is_post_user?, only: %i[edit]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render "new"
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.all
  end

  def edit; end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render "edit"
    end
  end 
  
  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  private
    def prototype_params
      params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    end

    def set_prototype
      @prototype = Prototype.find(params[:id])
    end

    def is_post_user?
      redirect_to root_path if current_user != @prototype.user
    end
end
