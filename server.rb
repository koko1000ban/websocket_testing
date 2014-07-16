require 'bundler/setup'
require 'em-websocket'
require 'dotenv'
Dotenv.load

EM.epoll
EM.set_descriptor_table_size 60000

EM.run {
  EM::WebSocket.run(host: '0.0.0.0', port: ENV['WS_PORT']) do |ws|
    ws.onopen{ |handshake|
      ws.send "hello world"
    }

    ws.onclose {
      puts "connection closed"
    }

    ws.onmessage {|msg|
      ws.send "Pong: #{msg}"
    }
  end
}