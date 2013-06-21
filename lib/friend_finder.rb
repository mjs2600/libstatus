require 'dnssd'

class FriendFinder
  def initialize
    DNSSD.browse '_ddi-udp-1._tcp.' do |reply|
      p reply
    end
  end

  def find_friends
  end

  def self.find_friends
    new.find_friends
  end
end

