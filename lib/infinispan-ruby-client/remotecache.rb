require 'socket'

class RemoteCache
	attr_accessor :host, :port, :cache_name

	def initialize host="localhost",port=11222,cache_name=""
		@host = host
		@port = port
    @cache_name = cache_name
    @opb = OperationBuilder.new(self)
	end

  def get key
    op = @opb.buildGET
    op.perform(key)
	end
	

	def put key,value
    op = @opb.buildPUT
    op.perform(key,value)
	end
  
  ## This method is retutning a plain TCPSocket, probably in the future I can find a better abstraction
  def get_transporter
    TCPSocket.open(@host, @port)
  end
  ## This method is retutning a plain TCPSocket, probably in the future I can find a better abstraction
  def release_transporter s
    s.close
  end
end