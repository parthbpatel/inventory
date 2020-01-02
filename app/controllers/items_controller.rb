class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order(params[:sort]).paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.xlsx { render xlsx: 'index', locals: {items: Item.all} }
      format.html {render :index}
    end  
  end

  # def index
  #   @items = Item.paginate(page: params[:page], per_page: 10)
  #   respond_to do |format|
  #     format.xlsx {
  #       response.headers['Content-Disposition'] = "attachment; filename = 'items.xlsx'"
  #     }
  #     format.html {render :index}
  #   end
  # end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :quantity)
    end
end
