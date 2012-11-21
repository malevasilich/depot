require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "valid cart with different products" do
  	cart = Cart.create
  	cart.add_product(products(:ruby).id).save
  	cart.add_product(products(:js).id).save
	assert cart.line_items.size==2  		
	assert cart.total_price==59.50
  end

  test "valid cart with same products" do
  	cart = Cart.create
  	cart.add_product(products(:ruby).id).save
  	cart.add_product(products(:ruby).id).save
	assert cart.line_items.size==1 		
	assert cart.total_price==49.5*2
  end
end
