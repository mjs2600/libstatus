require 'dnssd'

class Server
  attr_accessor :service, :udp_server

  def initialize port=8888
    @port = port
    setup
  end

  def setup
    @server = TCPServer.new @port
    @service = DNSSD.announce @server, 'A Status server'

    client = @server.accept # Wait for a client to connect
    client.puts "Hello! Welcome to my status server."
    client.puts "Time is #{Time.now}"

    Thread.start() do
      loop do
        puts client.gets
      end
    end

    loop do
      client.puts gets
    end

    client.close
  end
end
