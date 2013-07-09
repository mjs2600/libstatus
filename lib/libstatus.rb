#!/usr/bin/env ruby

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

class LibStatus
  def initialize
    @friend_finder = FriendFinder.new
  end
end
