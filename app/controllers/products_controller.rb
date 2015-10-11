class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :get_products,  only: [:index]
  def index
    respond_to do |format|
      format.js 
      format.html
    end
   
  end


  def show
    @category_name = Category.where(id: @product.category_ids.flatten)
  end

  def new
    @tags = Tag.all
    @categories = Category.all
    @product = Product.new
  end

  def edit
     @tags = Tag.all
     @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.category_ids = params[:product][:category_ids]
    @product.tag_list_ids = params[:product][:tag_list_ids]
    respond_to do |format|
      if @product.save
        format.html { redirect_to :controller => "admins", :action=>"index" }
        flash[:notice] = "Produit créé."
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
        format.html { redirect_to:controller => "admins", :action=>"index" }
        flash[:notice] = "Produit ajournée."
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
      format.html { redirect_to :controller => "admins", :action=>"index" }
      flash[:notice] = "Produit Effacé."
      format.json { head :no_content }
    end
  end
  def autocomplete
    render json: Product.search(params[:query], autocomplete: true, limit: 10).map(&:title)
  end
  def get_products
     if params[:commit].present?
        @products = Product.sort_filter(params[:tag_list_ids], params[:price], params[:weight])
      elsif params[:query].present?
        @products  = Product.where(state: "visible").search(params[:query]) #.rank(:row_product).paginate(:page => params[:page], :per_page => 5)
      else
          @products  = Product.where(state: "visible").rank(:row_product) #.paginate(:page => params[:page], :per_page => 5)
    end
    @tags = Tag.all
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end
    def product_params
      params.require(:product).permit(:name, :weight, :price, :description, :category_ids, :tag_list_ids, :image)
    end
end
