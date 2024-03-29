class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_buy, only: [:show]

  def index
    @item = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path if current_user != @item.user || Buyer.exists?(item_id: @item.id)
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    if current_user != @item.user
      redirect_to item_path(@item.id)
      return
    end

    redirect_to root_path if @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_explanation, :price, :category_id, :status_id, :shippingfee_id, :prefecture_id,
                                 :daystoship_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def check_buy
    @buyer = Buyer.exists?(item_id: @item.id)
  end
end
