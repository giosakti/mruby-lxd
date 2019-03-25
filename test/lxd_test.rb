require(File.expand_path('../mrblib/lxd', File.dirname(__FILE__)))

class LxdTest < MTest::Unit::TestCase
  def test_get_containers_success
    lxd = Lxd.new
    response = lxd.get_containers
    assert_equal(200, response.code)
  end

  def test_create_container_success
    lxd = Lxd.new
    container_source = ContainerSource.new(
      mode: 'pull', 
      server: 'https://cloud-images.ubuntu.com/releases', 
      protocol: 'simplestreams',
      source_alias: '18.04'
    )
    response = lxd.create_container('test-01', container_source)
    assert_equal(202, response.code)
  end
end

MTest::Unit.new.run
