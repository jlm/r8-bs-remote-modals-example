class ProductsController < ApplicationController
  def index
    @products = Product.order(id: :desc)
    # Search for items using OR: http://stackoverflow.com/questions/3639656/activerecord-or-query
    if params[:search].present?
      t = @products.arel_table
      match_string = "%#{params[:search]}%"
      @products = @products.where(t[:name].matches(match_string).or(t[:description].matches(match_string)))
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path
    else
      render :form_update, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path
    else
      render :form_update, status: :unprocessable_entity
    end
  end

  def destroy
    Product.destroy(params[:id])
    redirect_to products_path
  end

  private

  def product_params
    params.expect(product: [ :name, :description ])
  end
end
