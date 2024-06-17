# frozen_string_literal: true

class Api::V1::PlansController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @plans = Plan.all
    render json: @plans
  end

  def show
    @plan = Plan.find(params[:id])
    render json: @plan
  end
end
