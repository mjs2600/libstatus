require 'socket'

class Client
  attr_accessor :socket

  def initialize(host, port = 8888)

    Thread.start do
      @socket = TCPSocket.new host, port
      loop do
        prompt
        msg = socket.gets
        puts "Message: #{msg}" unless msg.strip.empty?
      end
    end

    loop do
      prompt
      msg = gets
      break if msg.strip == 'exit'
      socket.puts msg
    end

    socket.close if socket
  end

  def prompt
    print "> "
  end
end
