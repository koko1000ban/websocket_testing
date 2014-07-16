require 'bundler/setup'
require 'websocket-client-simple'
require 'dotenv'
Dotenv.load

def connect_ws(i)
  ws = WebSocket::Client::Simple.connect ENV['WS_SERVER_URI']
  ws.on :message do |msg|
    puts msg.data
  end

  loop do
    st = rand(20)
    sleep rand(20)
    ws.send i
  end
end

threads = 7000.times.map { |i|
  thread = Thread.new{ connect_ws(i) }
}
threads.each do |thread|
  thread.join
end