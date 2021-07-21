class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found_error

  def index
   if params[:user_id]
     user = User.find(params[:user_id])
     render json: user.items
    else
     items = Item.all
     render json: items, include: :user
    end
   
    end

    def show
      if params[:user_id]
        item = Item.find(params[:id])
       
        render json: item
      end
    end
 
  def create 
  user = User.find(params[:user_id])
  item = user.items.create(item_params)
  render json: item, status: :created
  end


    private 

    def handle_not_found_error
      render json: {status: "Error"}, status: :not_found
    end
   
    def item_params
      params.permit(:name, :description, :price)
    end

end
