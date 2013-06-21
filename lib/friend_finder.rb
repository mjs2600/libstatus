require 'dnssd'

class FriendFinder
  def initialize
    DNSSD.browse '_http._udp.' do |reply|
      p reply
    end
  end

  def setup
    status = UDPServer.new nil, 8888

    DNSSD.announce status, `scutil --get LocalHostName`
  end

  def find_friends
  end

  def self.find_friends
    new.find_friends
  end
end

