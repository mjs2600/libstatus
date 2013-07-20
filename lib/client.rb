class Client
  attr_accessor :port, :daemon, :host, :socket, :messages

  def initialize args = {}
    @port = args[:port] || 8888
    @daemon = args[:daemon].nil? ? true : args[:daemon]
    @host = args[:host] || 'localhost'

    @messages = []

    @socket = TCPSocket.new @host, @port

    start_listening

    console unless @daemon
  end

  def send(msg)
    @socket.puts msg
  end

  def stop
    unless @socket.closed?
      @socket.close
      @listen_thread.exit
      puts 'Client closed'
    end
  end

  def start_listening
    @listen_thread = Thread.start do
      loop do
        msg = socket.gets
        if @daemon
          @messages += [msg] unless msg.strip.empty?
        else
          puts "Message: #{msg}" unless msg.strip.empty?
        end
      end
    end
  end

  def console
    @daemon = false
    until @socket.closed? do
      prompt
      msg = gets
      stop if msg.strip == 'exit'
      @socket.puts msg
    end
    @daemon = true
  end

  def prompt
    print "> "
  end
end
