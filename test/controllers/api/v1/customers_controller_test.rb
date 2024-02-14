require "test_helper"

class Api::V1::CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_customer = api_v1_customers(:one)
  end

  test "should get index" do
    get api_v1_customers_url, as: :json
    assert_response :success
  end

  test "should create api_v1_customer" do
    assert_difference("Api::V1::Customer.count") do
      post api_v1_customers_url, params: { api_v1_customer: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_customer" do
    get api_v1_customer_url(@api_v1_customer), as: :json
    assert_response :success
  end

  test "should update api_v1_customer" do
    patch api_v1_customer_url(@api_v1_customer), params: { api_v1_customer: {  } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_customer" do
    assert_difference("Api::V1::Customer.count", -1) do
      delete api_v1_customer_url(@api_v1_customer), as: :json
    end

    assert_response :no_content
  end
end
