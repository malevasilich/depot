class StoreController < ApplicationController
  skip_before_filter :authorize

  def index
  	#@products = Product.order(:title)

    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
    else
      params[:locale] ||= I18n.default_locale
      @products = Product.where("locale=? or locale is null", params[:locale])
    	@cart = current_cart
    	@show_counter=false

    	session[:counter]=0 if session[:counter].nil? 
    	session[:counter] += 1
    	@show_counter=session[:counter]>5
    end
  end
end 
