require "test_helper"

class Api::V1::MotorcyclesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_motorcycle = api_v1_motorcycles(:one)
  end

  test "should get index" do
    get api_v1_motorcycles_url, as: :json
    assert_response :success
  end

  test "should create api_v1_motorcycle" do
    assert_difference("Api::V1::Motorcycle.count") do
      post api_v1_motorcycles_url, params: { api_v1_motorcycle: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_motorcycle" do
    get api_v1_motorcycle_url(@api_v1_motorcycle), as: :json
    assert_response :success
  end

  test "should update api_v1_motorcycle" do
    patch api_v1_motorcycle_url(@api_v1_motorcycle), params: { api_v1_motorcycle: {  } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_motorcycle" do
    assert_difference("Api::V1::Motorcycle.count", -1) do
      delete api_v1_motorcycle_url(@api_v1_motorcycle), as: :json
    end

    assert_response :no_content
  end
end
