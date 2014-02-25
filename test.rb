require 'net/http'

require 'net/ping'
require 'net/ping'

good = '192.168.1.56'
bad  = 'foo.bar.baz'

p1 = Net::Ping::External.new(good)
x= p1.ping?
p x
p x.class

p2 = Net::Ping::External.new(bad)
p p2.ping?

