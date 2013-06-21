require 'socket'

class Client

  def initialize(host, port = 8888)
    server = TCPsocket.new host, port

    Thread.start do
      loop do
        puts server.gets
      end
    end

    loop do
      server.puts gets
    end

    server.close
  end
end