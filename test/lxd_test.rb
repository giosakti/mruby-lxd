require(File.expand_path('../mrblib/lxd', File.dirname(__FILE__)))

class LxdTest < MTest::Unit::TestCase
  def shared_vars
    {
      container_source: ContainerSource.new(
        mode: 'pull', 
        server: 'https://cloud-images.ubuntu.com/releases', 
        protocol: 'simplestreams',
        source_alias: '18.04'
      )
    }
  end

  def test_get_containers_success
    lxd = Lxd.new
    response = lxd.get_containers
    assert_equal(200, response.code)
  end

  def test_get_container_success
    lxd = Lxd.new
    lxd.create_container(
      hostname: 'test-01',
      container_source: shared_vars[:container_source]
    )
    response = lxd.get_container(hostname: 'test-01')
    assert_equal(200, response.code)
    lxd.delete_container(hostname: 'test-01')
  end

  def test_create_container_success
    lxd = Lxd.new
    response = lxd.create_container(
      hostname: 'test-01',
      container_source: shared_vars[:container_source]
    )
    assert_equal(202, response.code)
    lxd.delete_container(hostname: 'test-01')
  end

  def test_create_container_sync_success
    lxd = Lxd.new
    response = lxd.create_container(
      hostname: 'test-01', 
      container_source: shared_vars[:container_source], 
      sync: true
    )
    get_response = lxd.get_container(hostname: 'test-01')
    assert_equal(200, get_response.code)
    lxd.delete_container(hostname: 'test-01')
  end

  def test_start_container_success
    lxd = Lxd.new
    lxd.create_container(
      hostname: 'test-01', 
      container_source: shared_vars[:container_source], 
      sync: true
    )
    response = lxd.start_container(hostname: 'test-01')
    assert_equal(202, response.code)
    lxd.delete_container(hostname: 'test-01', force: true)
  end

  def test_stop_container_success
    lxd = Lxd.new
    lxd.create_container(
      hostname: 'test-01', 
      container_source: shared_vars[:container_source], 
      sync: true
    )
    lxd.start_container(hostname: 'test-01')
    sleep(3)
    lxd.stop_container(hostname: 'test-01')
    get_response = lxd.get_container(hostname: 'test-01')
    assert_equal(102, JSON.parse(get_response.body)['metadata']['status_code'])
    lxd.delete_container(hostname: 'test-01', force: true)
  end

  def test_delete_container_success
    lxd = Lxd.new
    lxd.create_container(
      hostname: 'test-01', 
      container_source: shared_vars[:container_source], 
      sync: true
    )
    response = lxd.delete_container(hostname: 'test-01')
    assert_equal(202, response.code)
  end
end

MTest::Unit.new.run
