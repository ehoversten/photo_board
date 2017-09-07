class PinsController < ApplicationController
  before_action :authenticate_user!

  before_action :find_pin, only: [:show ,:edit, :update, :destroy ]

  before_action :owned_post, only: [:edit, :update, :destroy]

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
      flash[:success] = "Pin Created"
      redirect_to @pin
    else
      flash[:alert] = "Your new post couldn't be created!  Please check the form."
      render 'new'
    end
  end

  def edit

  end

  def update
    if @pin.update(pin_params)
      flash[:success] = "Magically Updated"
      redirect_to @pin
    else
      render 'edit'
    end
  end

  def destroy
    @pin.destroy
    flash[:success] = "It's Gone NOW!"
    redirect_to root_path
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description, :image)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end

  def owned_post
    unless current_user == @pin.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

end
