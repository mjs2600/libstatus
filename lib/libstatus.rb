#!/usr/bin/env ruby

require_relative './friend_finder'

class LibStatus
  def initialize
    @friend_finder = FriendFinder.new
  end
end
