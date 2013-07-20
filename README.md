libstatus
=========

A library for finding people to connect with on Status in your local network

#### Usage:

You may use this library directly from the console:

```ruby
$ ./script/console
[1] pry(main)> s = Server.new
=> #<Server:0x007f9f038ffaa8
@daemon=true,
@listen_thread=#<Thread:0x007f9f038ff6c0 sleep>,
@messages=[],
@port=8888,
@server=#<TCPServer:fd 8>,
@service=#<DNSSD::Service:0x3fcf81c7fc14 running>>
[2] pry(main)> c = Client.new
=> #<Client:0x007f9f0392e268
@daemon=true,
@host="localhost",
@listen_thread=#<Thread:0x007f9f0392e178 sleep>,
@messages=[],
@port=8888,
@socket=#<TCPSocket:fd 10>>
[3] pry(main)> s.send 'foo'
=> nil
[4] pry(main)> c.messages
=> ["Hello! Welcome to my status server.\n",
"Time is 2013-07-20 12:16:57 -0400\n",
"foo\n"]
[5] pry(main)> c.send 'bar'
=> nil
[6] pry(main)> s.messages
=> ["bar\n"]
```
