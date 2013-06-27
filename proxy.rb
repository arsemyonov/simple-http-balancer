require 'rubygems'
require 'bundler'

Bundler.require(:default)

$: << File.join(File.dirname(__FILE__), 'lib')

require 'proxy'
require 'yaml'

require './config'

class MySuperBalancer
  class << self

    def run
      EM.epoll
      EM.run do
        trap('TERM') { stop }
        trap('INT')  { stop }

        Proxy::Manager::Applications.new.run
      end
    end

    def stop
      EM.stop
    end

  end
end

if __FILE__ == $0
  MySuperBalancer.run
end
