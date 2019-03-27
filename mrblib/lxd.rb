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

  def get_container(hostname:)
    res = @client.request(
      'GET',
      "/1.0/containers/#{hostname}",
      {}
    )
  end

  def get_container_address(hostname:, timeout: 60, check_interval: 2)
    ipaddress = nil
    found = false
    time_limit = Time.now + timeout

    while !found && (Time.now < time_limit) do
      res = @client.request(
        'GET',
        "/1.0/containers/#{hostname}/state",
        {}
      )
      addresses = JSON.parse(res.body).dig('metadata', 'network', 'eth0', 'addresses') || []
      addresses.each do |address|
        if address['family'] == 'inet'
          ipaddress = address['address']
        end
      end

      unless ipaddress.nil?
        found = true
        break
      end

      sleep(check_interval)
    end

    if found
      return true, ipaddress
    else
      return false, nil
    end
  end

  def create_container(hostname:, container_source:, sync: true)
    payload = { name: hostname, source: container_source.to_h }.to_json
    res = @client.request(
      'POST',
      '/1.0/containers',
      craft_request_body(payload)
    )
    wait_for_operation(res) if sync
    return res
  end

  def start_container(hostname:, sync: true)
    payload = { action: 'start', timeout: -1 }.to_json
    res = @client.request(
      'PUT',
      "/1.0/containers/#{hostname}/state",
      craft_request_body(payload)
    )
    wait_for_operation(res) if sync
    return res
  end

  def stop_container(hostname:, force: false, sync: true)
    payload = { action: 'stop', force: force, timeout: 60 }.to_json
    res = @client.request(
      'PUT',
      "/1.0/containers/#{hostname}/state",
      craft_request_body(payload)
    )
    wait_for_operation(res) if sync
    return res
  end

  def delete_container(hostname:, force: false, sync: true)
    stop_container(hostname: hostname, force: force, sync: sync)
    res = @client.request(
      'DELETE',
      "/1.0/containers/#{hostname}",
      {}
    )
    wait_for_operation(res) if sync
    return res
  end

  private

  def craft_request_body(payload)
    {
      'Body' => payload,
      'Content-Type' => 'application/json; charset=utf-8',
      'Content-Length' => payload.length 
    }
  end

  def wait_for_operation(res)
    op_id = JSON.parse(res.body)['metadata']['id']
    res = @client.request(
      'GET',
      "/1.0/operations/#{op_id}/wait",
      {}
    )
  end
end
