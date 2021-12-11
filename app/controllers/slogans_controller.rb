class SlogansController < BaseController

  before_action :load_slogan, only: [:show, :update, :destroy]

  def index
    @slogans = Slogan.order("RANDOM()").page(params[:page]).per(params[:per_page])
    render json: @slogans
  end

  def show
    render json: @slogan
  end

  def create
    @slogan = Slogan.new(slogan_params)
    if @slogan.save
      render json: @slogan, status: :created, location: @slogan
    else
      render json: { errors: @slogan.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @slogan.update(slogan_params)
      render json: @slogan
    else
      render json: { errors: @slogan.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @slogan.destroy
  end

  private

    def slogan_params
      params.require(:slogan).permit(:title)
    end

    def load_slogan
      @slogan = Slogan.find(params[:id])
    end

end
