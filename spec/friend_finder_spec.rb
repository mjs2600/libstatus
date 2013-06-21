require './lib/friend_finder'

describe "FriendFinder" do
  it 'should find other clients' do
    FriendFinder.new.should be_a FriendFinder
  end

  it 'should retrieve metadata from friends'
end
