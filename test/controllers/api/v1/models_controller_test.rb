require "test_helper"

class Api::V1::ModelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_model = api_v1_models(:one)
  end

  test "should get index" do
    get api_v1_models_url, as: :json
    assert_response :success
  end

  test "should create api_v1_model" do
    assert_difference("Api::V1::Model.count") do
      post api_v1_models_url, params: { api_v1_model: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_model" do
    get api_v1_model_url(@api_v1_model), as: :json
    assert_response :success
  end

  test "should update api_v1_model" do
    patch api_v1_model_url(@api_v1_model), params: { api_v1_model: {  } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_model" do
    assert_difference("Api::V1::Model.count", -1) do
      delete api_v1_model_url(@api_v1_model), as: :json
    end

    assert_response :no_content
  end
end
