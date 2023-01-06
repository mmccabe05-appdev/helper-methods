class DirectorsController < ApplicationController
  def new
    @director = Director.new

    render template: "directors/new"
  end

  def index
    @directors = Director.order created_at: :desc

    respond_to do |format|
      format.json do
        render json: @directors
      end

      format.html
      
    end
  end

  def show
    @director  = Director.find(params.fetch(:id))
  end

  def create

    director_attributes = params.require(:director).permit(:name, :dob)

    @director = Director.new(director_attributes)

    if @director.valid?
      @director.save
      redirect_to directors_url, notice: "director created successfully."
    else
      render "new"    
    end
  end

  def edit
    @director = Director.find(params.fetch(:id))

  end

  def update
    # will update with above in a minute

    @director = Director.find(params.fetch(:id))
    director_attributes = params.require(:director).permit(:name, :dob)
    @Director.update(director_attributes)
    # @Director.title = params.fetch(:name)
    # @Director.description = params.fetch(:dob)

    if @Director.valid?
      @Director.save
      redirect_to director_url(@director), notice: "director updated successfully."
    else
      redirect_to director_url(@director), alert: "director failed to update successfully."
    end
  end

  def destroy
    director = Director.find(params.fetch(:id))

    Director.destroy

    redirect_to directors_url, notice: "director deleted successfully."
  end
end
