class DrinksController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create]

def index
      if params[:search] == nil 
            drinks= Drink.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
            @drinks = Kaminari.paginate_array(drinks).page(params[:page]).per(6)
      elsif params[:search] == ''
            drinks= Drink.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
            @drinks = Kaminari.paginate_array(drinks).page(params[:page]).per(6)
      else 
            params[:search] != nil && params[:search] != ''
            search = params[:search]
            @drinks = Drink.joins(:user).where("shop LIKE ? OR name LIKE ? OR base LIKE ?", '%' + params[:search] + '%', '%' + params[:search] + '%', '%' + params[:search] + '%').page(params[:page]).per(6)
      end
end

def new
    @drink = Drink.new
end

def create
    drink = Drink.new(drink_params)
    drink.user_id = current_user.id
    if drink.save
        redirect_to :action => "index"
    else
        redirect_to :action => "new"
    end
end

def show
    @drink = Drink.find(params[:id])
    @comments = @drink.comments
    @comment = Comment.new
end

def edit
    @drink = Drink.find(params[:id])
end

def update
    drink = Drink.find(params[:id])
    if drink.update(drink_params)
        redirect_to :action => "show", :id => drink.id
    else
        redirect_to :action => "new"
    end
end

def destroy
    drink = Drink.find(params[:id])
    drink.destroy
    redirect_to action: :index
end

private
  def drink_params
    params.require(:drink).permit(:name, :shop, :base, :about, :recipe, :image)
  end

end
