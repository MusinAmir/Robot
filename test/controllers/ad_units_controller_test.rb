require 'test_helper'

class AdUnitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ad_unit = ad_units(:one)
  end

  test "should get index" do
    get ad_units_url
    assert_response :success
  end

  test "should get new" do
    get new_ad_unit_url
    assert_response :success
  end

  test "should create ad_unit" do
    assert_difference('AdUnit.count') do
      post ad_units_url, params: { ad_unit: { account_id: @ad_unit.account_id, name: @ad_unit.name, url: @ad_unit.url } }
    end

    assert_redirected_to ad_unit_url(AdUnit.last)
  end

  test "should show ad_unit" do
    get ad_unit_url(@ad_unit)
    assert_response :success
  end

  test "should get edit" do
    get edit_ad_unit_url(@ad_unit)
    assert_response :success
  end

  test "should update ad_unit" do
    patch ad_unit_url(@ad_unit), params: { ad_unit: { account_id: @ad_unit.account_id, name: @ad_unit.name, url: @ad_unit.url } }
    assert_redirected_to ad_unit_url(@ad_unit)
  end

  test "should destroy ad_unit" do
    assert_difference('AdUnit.count', -1) do
      delete ad_unit_url(@ad_unit)
    end

    assert_redirected_to ad_units_url
  end
end
