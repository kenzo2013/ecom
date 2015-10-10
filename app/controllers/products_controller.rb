class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # GET /products
  # GET /products.json
  def index
    if params[:query].present?
      @products  = Product.search(params[:query]).rank(:row_product).paginate(:page => params[:page], :per_page => 5)
    else
      @products  = Product.rank(:row_product).paginate(:page => params[:page], :per_page => 5)
    end
  end

  def show
    @category_name = Category.where(id: @product.category_ids.flatten)
  end

  def new
    @categories = Category.all
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    @product.category_ids = params[:product][:category_ids].split(",")
    @product.tag_list = params[:product][:tag_list].split(",")
    respond_to do |format|
      if @product.save
        format.html { redirect_to :action=>"index", notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  def update_row_product
    @product = Product.find(product_params[:product_id])
    @product.row_product_position = product_params[:row_product_position]
    @product.save
    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  
  

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def autocomplete
    render json: Product.search(params[:query], autocomplete: true, limit: 10).map(&:title)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end
    def product_params
      params.require(:product).permit(:name, :weight, :price, :description, :tag_list, :image)
    end
end
