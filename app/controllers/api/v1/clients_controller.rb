class ClientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @clients = current_user.business_unit.clients
    render json: @clients
  end

  def show
    @client = Client.find(params[:id])
    render json: @client
  end

  def create
    @client = current_user.business_unit.clients.build(client_params)
    if @client.save
      render json: @client, status: :created
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    head :no_content
  end

  private

  def client_params
    params.require(:client).permit(:name, :email)
  end
end
