class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @ideas = Idea.last(20)

  end


  def new
    @idea = Idea.new
  end

  def create

    idea_params = params.require(:idea).permit([:title, :body ])
    @idea = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      redirect_to ideas_path
    else
      render :new
    end
  end

  def show
    @idea = Idea.find params[:id]
    @review = Review.new
  end

  def destroy
      @idea = Idea.find params[:id]
      if can? :destroy, @idea
       @idea.destroy
       redirect_to ideas_path, notice: 'idea delete'
     else
       redirect_to root_path, alert: 'Access denied'
     end
    end

    def edit
      @idea = Idea.find params[:id]
      redirect_to root_path, alert: 'access denited' unless can? :edit, @idea

    end


    def update
    @idea = Idea.find params[:id]
    idea_params = params.require(:idea).permit([:title, :body])

    if !(can? :edit, @idea)
        redirect_to root_path, alert: 'acess denied'
      elsif @idea.update(idea_params)
        redirect_to idea_path(@idea), notice: 'idea updated'
      else
        render :edit
      end
  end
end
