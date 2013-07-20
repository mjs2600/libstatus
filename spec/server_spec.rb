require 'spec_helper'

describe "Server" do
  before(:each) do
    @server = Server.new port: 12345
  end

  after(:each) do
    @server.stop
  end

  it 'creates a valid socket' do
    @server.server.should_not be_closed
    @server.stop
    @server.server.should be_closed
  end

  it 'should receive messages' do
    @server.messages.should be_empty
    @client = Client.new port: 12345
    @client.socket.should_not be_closed
    @server.server.should_not be_closed
    @client.send 'test'
    sleep 1
    @server.messages.should include "test\n"
  end
end
