class PrototypesController < ApplicationController
     before_action :authenticate_user!, except: [ :index, :show]
     before_action :set_prototype, except: [ :index, :new]
     before_action :move_to_index, except: [:index, :show, :new]
    
                                        
  
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
      render :new
    end
  end
  
  def show
    
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    
  end

  def update
    
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
  end



  private
  def prototype_params
    params.require(:prototype).permit(:name, :title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end



  def set_prototype
    @prototype = Prototype.find(params[:id])
  end




  def move_to_index
    if @prototype.user.name == current_user.name
      render :edit
    else
      redirect_to action: :index
    end
  end

end
