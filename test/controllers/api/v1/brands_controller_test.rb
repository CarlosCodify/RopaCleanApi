require "test_helper"

class Api::V1::BrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_brand = api_v1_brands(:one)
  end

  test "should get index" do
    get api_v1_brands_url, as: :json
    assert_response :success
  end

  test "should create api_v1_brand" do
    assert_difference("Api::V1::Brand.count") do
      post api_v1_brands_url, params: { api_v1_brand: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_brand" do
    get api_v1_brand_url(@api_v1_brand), as: :json
    assert_response :success
  end

  test "should update api_v1_brand" do
    patch api_v1_brand_url(@api_v1_brand), params: { api_v1_brand: {  } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_brand" do
    assert_difference("Api::V1::Brand.count", -1) do
      delete api_v1_brand_url(@api_v1_brand), as: :json
    end

    assert_response :no_content
  end
end
