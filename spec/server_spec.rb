require './lib/server'

describe "Server" do
  it 'should broadcast metadata' do
    s = Server.new
    s.service.should be_a 
    p s.service
  end
end
