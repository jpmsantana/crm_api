# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show update destroy]

  def index
    @customers = Customer.all
  end

  def show; end

  def create
    @customer = Customer.new(customer_params)
    @customer.user = current_user
    return if @customer.save

    render json: {}, status: :unprocessable_entity
    nil
  end

  def update
    return if @customer.update(customer_params)

    render json: {}, status: :unprocessable_entity
    nil
  end

  def destroy
    @customer.destroy
    render json: {}
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :surname, :photo)
  end
end
