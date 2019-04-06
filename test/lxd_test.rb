require(File.expand_path('../mrblib/lxd', File.dirname(__FILE__)))

class LxdTest < MTest::Unit::TestCase
  def shared_vars
    {
      container_source: MrubyLxd::ContainerSource.new(
        mode: 'pull', 
        server: 'https://cloud-images.ubuntu.com/releases', 
        protocol: 'simplestreams',
        source_alias: '18.04'
      )
    }
  end

  def test_get_containers_success
    lxd = MrubyLxd::Lxd.new
    ok, _ = lxd.get_containers
    assert_equal(true, ok)
  end

  def test_get_container_success
    lxd = MrubyLxd::Lxd.new
    lxd.create_container(
      hostname: 'test-01',
      container_source: shared_vars[:container_source]
    )
    ok, _ = lxd.get_container(hostname: 'test-01')
    assert_equal(true, ok)
    lxd.delete_container(hostname: 'test-01')
  end

  def test_get_container_state_success
    lxd = MrubyLxd::Lxd.new
    lxd.create_container(
      hostname: 'test-01',
      container_source: shared_vars[:container_source]
    )
    ok, _ = lxd.get_container_state(hostname: 'test-01')
    assert_equal(true, ok)
    lxd.delete_container(hostname: 'test-01')
  end

  def test_get_container_address_success
    lxd = MrubyLxd::Lxd.new
    lxd.create_container(
      hostname: 'test-01',
      container_source: shared_vars[:container_source]
    )
    lxd.start_container(hostname: 'test-01')
    ok, ip = lxd.get_container_address(hostname: 'test-01')
    assert_equal(true, ok)
    lxd.delete_container(hostname: 'test-01')
  end

  def test_create_container_success
    lxd = MrubyLxd::Lxd.new
    ok = lxd.create_container(
      hostname: 'test-01',
      container_source: shared_vars[:container_source]
    )
    assert_equal(true, ok)
    lxd.delete_container(hostname: 'test-01')
  end

  def test_create_container_sync_success
    lxd = MrubyLxd::Lxd.new
    response = lxd.create_container(
      hostname: 'test-01', 
      container_source: shared_vars[:container_source], 
      sync: true
    )
    ok, _ = lxd.get_container(hostname: 'test-01')
    assert_equal(true, ok)
    lxd.delete_container(hostname: 'test-01')
  end

  def test_start_container_success
    lxd = MrubyLxd::Lxd.new
    lxd.create_container(
      hostname: 'test-01', 
      container_source: shared_vars[:container_source], 
      sync: true
    )
    ok = lxd.start_container(hostname: 'test-01')
    assert_equal(true, ok)
    lxd.delete_container(hostname: 'test-01', force: true)
  end

  def test_stop_container_success
    lxd = MrubyLxd::Lxd.new
    lxd.create_container(
      hostname: 'test-01', 
      container_source: shared_vars[:container_source], 
      sync: true
    )
    lxd.start_container(hostname: 'test-01')
    sleep(3)
    lxd.stop_container(hostname: 'test-01')
    _, container_state = lxd.get_container_state(hostname: 'test-01')
    assert_equal(102, container_state.status_code)
    lxd.delete_container(hostname: 'test-01', force: true)
  end

  def test_delete_container_success
    lxd = MrubyLxd::Lxd.new
    lxd.create_container(
      hostname: 'test-01', 
      container_source: shared_vars[:container_source], 
      sync: true
    )
    ok = lxd.delete_container(hostname: 'test-01')
    assert_equal(true, ok)
  end
end

MTest::Unit.new.run
