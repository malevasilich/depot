class StoreController < ApplicationController
  def index
  	#@products = Product.order(:title)
  	@products = Product.all
  	@cart = current_cart
  	@show_counter=false

  	session[:counter]=0 if session[:counter].nil? 
	session[:counter] += 1
	@show_counter=session[:counter]>5
  end
end 
