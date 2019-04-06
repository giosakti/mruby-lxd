module MrubyLxd
  class Container
    attr_reader :hostname, :ipaddress, :image

    def initialize(hostname:, ipaddress: '', image: '')
      @hostname = hostname
      @ipaddress = ipaddress
      @image = image
    end
  end
end
