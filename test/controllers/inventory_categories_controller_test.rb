require "test_helper"

class InventoryCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventory_category = inventory_categories(:one)
  end

  test "should get index" do
    get inventory_categories_url, as: :json
    assert_response :success
  end

  test "should create inventory_category" do
    assert_difference("InventoryCategory.count") do
      post inventory_categories_url, params: { inventory_category: { business_unit_id: @inventory_category.business_unit_id, name: @inventory_category.name } }, as: :json
    end

    assert_response :created
  end

  test "should show inventory_category" do
    get inventory_category_url(@inventory_category), as: :json
    assert_response :success
  end

  test "should update inventory_category" do
    patch inventory_category_url(@inventory_category), params: { inventory_category: { business_unit_id: @inventory_category.business_unit_id, name: @inventory_category.name } }, as: :json
    assert_response :success
  end

  test "should destroy inventory_category" do
    assert_difference("InventoryCategory.count", -1) do
      delete inventory_category_url(@inventory_category), as: :json
    end

    assert_response :no_content
  end
end
