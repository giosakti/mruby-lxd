class Lxd
  def initialize(opts = {})
    opts[:scheme] ||= 'unix'
    opts[:address] ||= '/var/snap/lxd/common/lxd/unix.socket'
    @client = SimpleHttp.new(opts[:scheme], opts[:address], opts[:port])
  end

  def get_containers
    res = @client.request(
      'GET',
      '/1.0/containers',
      {}
    )
  end
end
