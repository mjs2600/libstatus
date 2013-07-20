require 'dnssd'

class Server
  include Loggable

  attr_accessor :server, :service, :client, :port, :daemon, :messages

  def initialize args = {}
    @port = args[:port] || 8888
    @daemon = args[:daemon].nil? ? true : args[:daemon]

    @messages = []

    start
  end

  def start
    setup

    @listen_thread = Thread.start() do
      @client = @server.accept # Wait for a client to connect

      if @daemon
        log_info 'Client connected.'
      else
        puts
        puts 'Client connected.'
        prompt
      end

      @client.puts "Hello! Welcome to my status server."
      @client.puts "Time is #{Time.now}"

      until @server.closed? do
        msg = @client.gets
        if @daemon
          @messages += [msg] unless msg.strip.empty?
        else
          puts "Message: #{msg}" unless msg.strip.empty?
          prompt
        end
      end
    end

    console unless daemon
  end

  def setup
    @server = TCPServer.new port
    @service = DNSSD.announce @server, "A Status server on #{Socket.gethostname}", 'status'
  end

  def send(msg)
    @client.puts msg.strip unless msg.strip.empty?
  end

  def stop
    unless @server.closed?
      @client.close unless @client.closed? if @client
      @server.close
      @listen_thread.exit
      log_info 'Server closed'
    end
  end

  def console
    @daemon = false
    loop do
      prompt
      msg = gets
      break if msg.strip == 'exit'
      @client.puts msg
    end
    @daemon = true
  end

  def prompt
    print "> "
  end
end
