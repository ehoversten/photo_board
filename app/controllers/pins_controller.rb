class PinsController < ApplicationController
  before_action :authenticate_user!

  before_action :find_pin, only: [:show ,:edit, :update, :destroy ]

  def index
    @pins = Pin.all
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build(pin_params)

    if @pin.save
      redirect_to @pin, notice: "Success!!"
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @pin.update(pin_params)
     redirect_to @pin, notice: "Magically Updated!!"
    else
     render 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to root_path, notice: "It's Gone NOW!!"
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description, :image)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
