module MrubyLxd
  class ContainerSource
    def initialize(type: 'image', mode: 'local', server: '', protocol: 'lxd', source_alias: '')
      @type = type          # 'image', 'migration', 'copy' or 'none'
      @mode = mode          # 'local' (default) or 'pull'
      @server = server      # pull mode only
      @protocol = protocol  # 'lxd' (default) or 'simplestreams'
      @alias = source_alias
    end

    def to_h
      {
        type: @type,
        mode: @mode,
        server: @server,
        protocol: @protocol,
        alias: @alias
      }
    end
  end
end