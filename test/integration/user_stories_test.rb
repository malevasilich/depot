# encoding: utf-8
require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest 
	fixtures :products

	# A user goes to the index page. They select a product, adding it to their	
	# cart, and check out, filling in their details on the checkout form. When
	# they submit, an order is created containing their information, along with a
	# single line item corresponding to the product they added to their cart.
	test "buying a product" do 
		LineItem.delete_all
		Order.delete_all
		ruby_book = products(:ruby)

		get "/"
		assert_response :success
		assert_template "index"

		xml_http_request :post, "/line_items", product_id: ruby_book.id
		assert_response :success

		cart = Cart.find(session[:cart_id])
		assert_equal 1, cart.line_items.size
		assert_equal ruby_book, cart.line_items[0].product

		get "/orders/new"
		assert_response	:success
		assert_template "new"

		post_via_redirect "/orders",
							order: {
								name: "Петр Грицевич",
								address: "пр. Абая 181, уг. ул. Масанчи, каб. 317",
								email: "pgritsevich@the_company_that_wasnt_here.kz",
								pay_type: "Credit card"
							}
		assert_response :success
		assert_template "index"
		cart = Cart.find(session[:cart_id])
		assert_equal 0, cart.line_items.size

		orders = Order.all
		assert_equal orders.size, 1
		order = orders[0]

		assert_equal order.name, "Петр Грицевич"
		assert_equal order.address, "пр. Абая 181, уг. ул. Масанчи, каб. 317"
		assert_equal order.email, "pgritsevich@the_company_that_wasnt_here.kz"
		assert_equal order.pay_type, "Credit card"

		assert_equal order.line_items.size, 1
		line_item = order.line_items[0]
		assert_equal line_item.product, ruby_book

		mail = ActionMailer::Base.deliveries.last
		assert_equal mail.to, ["pgritsevich@the_company_that_wasnt_here.kz"]
		assert_equal mail[:from].value, "malevasilich@example.com"
		assert_equal mail.subject, "Pragmatic Store Order Confirmation"


	end

end
