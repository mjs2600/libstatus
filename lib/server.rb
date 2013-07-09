require 'dnssd'

class Server
  attr_accessor :service, :udp_server, :client, :port, :server

  def initialize port=8888
    @port = port
    setup
  end

  def setup
    @server = TCPServer.new port
    @service = DNSSD.announce server, "A Status server on #{Socket.gethostname}"

    Thread.start() do
      @client = server.accept # Wait for a client to connect
      puts 'Client connected.'
      client.puts "Hello! Welcome to my status server."
      client.puts "Time is #{Time.now}"
      loop do
        prompt
        msg = client.gets
        puts "Message: #{msg}" unless msg.strip.empty?
      end
    end

    loop do
      prompt
      msg = gets
      break if msg.strip == 'exit'
      client.puts msg
    end

    client.close if client
    server.close if server
  end

  def prompt
    print "> "
  end
end
