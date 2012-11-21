require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
	assert_select '#columns #side a', minimum: 4
	assert_select '#main .entry', 4
	assert_select 'h3', 'Programming Ruby 1.9'
	assert_select '.price', /\$[,\d]+\.\d\d/
  end

  test "markup needed for store.js.coffee is in place" do
    get :index
    assert_select '.store .entry a > img', 4
    assert_select '.entry a[data-method="post"]', 4
  end

end
