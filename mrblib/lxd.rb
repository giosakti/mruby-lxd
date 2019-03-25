require(File.expand_path('./container_source', File.dirname(__FILE__)))

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

  def create_container(hostname, container_source)
    payload = { name: hostname, source: container_source.to_h }.to_json
    res = @client.request(
      'POST',
      '/1.0/containers',
      craft_request_body(payload)
    )
  end

  private

  def craft_request_body(payload)
    {
      'Body' => payload,
      'Content-Type' => 'application/json; charset=utf-8',
      'Content-Length' => payload.length 
    }
  end
end
