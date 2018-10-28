class AssetsController < ApplicationController

  before_action :authorize_access_request!

  def index
    @assets = Asset.all
    render json: @assets, adapter: :attributes
  end

  def show
    @asset = Asset.find(params[:id])
    render json: @asset, adapter: :attributes
  end

  def create
    @asset = Asset.new(asset_params)
    if @asset.save
      render json: @asset, status: :created, location: @asset, adapter: :attributes
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
