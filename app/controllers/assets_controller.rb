class AssetsController < ApplicationController

  include CurrentUser

  before_action :load_current_user

  def index
    @assets = Asset.all
    render json: @assets
  end

  def show
    @asset = Asset.find(params[:id])
    render json: @asset
  end

  def create
    @asset = Asset.new(asset_params)
    if @asset.save
      render json: @asset, status: :created, location: @asset
    else
      render json: { errors: @asset.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
  end

  private

    def asset_params
      params.require(:asset).permit(:attachment)
    end

end
