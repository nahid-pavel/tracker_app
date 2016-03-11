class UserStocksController < ApplicationController
  before_action :set_user_stock, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user_stocks = UserStock.all
    respond_with(@user_stocks)
  end

  def show
    respond_with(@user_stock)
  end

  def new
    @user_stock = UserStock.new
    respond_with(@user_stock)
  end

  def edit
  end

  def create
     if params[:stock_id].present?

        @user_stock = UserStock.new(user_id: current_user.id, stock_id: params[:stock_id])

     else

       stock = Stock.find_by_ticker(params[:stock_ticker])

       if stock

           @user_stock = UserStock.new(user_id: current_user.id, stock_id: stock.id)

       else

           stock = Stock.new_from_lookup(params[:stock_ticker])

           if stock.save
               
                @user_stock = UserStock.new(user_id: current_user.id, stock_id: stock.id)
           else

               @user_stock = nil

               flash[:error]="Stock is not available"

            end
         end
      end
      if @user_stock.save

         redirect_to  my_portfolio_path, notice: "Stock #{@user_stock.stock.ticker} was successfully created"

      else

        render 'new'

      end


    
  end

  def update
    @user_stock.update(user_stock_params)
    respond_with(@user_stock)
  end

  def destroy
    @user_stock.destroy
    respond_with(@user_stock)
  end

  private
    def set_user_stock
      @user_stock = UserStock.find(params[:id])
    end

    def user_stock_params
      params.require(:user_stock).permit(:user_id, :stock_id)
    end
end
