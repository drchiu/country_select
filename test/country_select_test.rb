require File.dirname(__FILE__) + '/test_helper'

# to test the modified methods
class CountrySelectTest < ActionView::TestCase
  
  # this works!
  test "basic test" do
    assert true
  end
  
  test "countries constants should be an array" do
    assert COUNTRIES.is_a?(Array)
  end
  
  test "default north american constants and european countries" do
    assert_not_nil NA_COUNTRIES
    assert_not_nil EUROPEAN_COUNTRIES
  end
  
  test "country_options_for_select will return default" do
    assert_not_nil country_options_for_select
  end
  
  test "set_world_regions_option should return countries" do
    # TODO
    # --
    # problem was it wasn't returning value, because forgotten last value
  end

end