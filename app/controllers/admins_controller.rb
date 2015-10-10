class AdminsController < ApplicationController
  before_action :set_product, only: [:to_visible, :to_invisible]
  
  def index
    @products = Product.all
    respond_to do |format|
      format.js 
      format.html
    end
  end
  
  def to_invisible
    @product.invisible
    @products = Product.all
    respond_to do |format|
      format.js 
    end
  end
  
  def to_visible
    @product.visible
    @products = Product.all
    respond_to do |format|
      format.js 
    end
  end
  def set_product
    @product = Product.find(params[:id])
  end
end
