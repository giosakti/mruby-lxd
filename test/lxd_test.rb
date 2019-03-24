require(File.expand_path('../mrblib/lxd', File.dirname(__FILE__)))

class LxdTest < MTest::Unit::TestCase
  def test_get_containers_success
    lxd = Lxd.new
    response = lxd.get_containers
    assert_equal(200, response.code)
  end
end

MTest::Unit.new.run
