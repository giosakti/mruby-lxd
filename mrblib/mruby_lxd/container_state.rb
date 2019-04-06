module MrubyLxd
  class ContainerState
    attr_reader :hostname, :status, :status_code, :disk, :memory, :network, :cpu

    def initialize(hostname:, status:, status_code:, disk: {}, memory: {}, network: {}, cpu: {})
      @hostname = hostname
      @status = status
      @status_code = status_code
      @disk = disk
      @memory = memory
      @network = network
      @cpu = cpu
    end
  end
end
