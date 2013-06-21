require 'dnssd'

class Server
  attr_accessor :service, :udp_server

  def initialize port=8888
    @port = port
    setup
  end

  def setup
    @server = TCPServer.new @port
    @service = DNSSD.announce @server, "A Status server at port #{@port}"

    client = @server.accept # Wait for a client to connect
    puts 'Client connected.'
    client.puts "Hello! Welcome to my status server."
    client.puts "Time is #{Time.now}"

    Thread.start() do
      loop do
        puts client.gets
      end
    end

    loop do
      msg = gets
      break if msg.strip == 'exit'
      client.puts msg
    end

    client.close
    @server.close
  end
end
