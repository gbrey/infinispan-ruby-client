class Operation
  attr_accessor :header
  def initialize(rm)
    @remotecache=rm
  end
  
  ## I know this dispacher method is kind of ugly, but for know this is how I code in ruby
  def perform(*params)
    if(params.size==2)
      perform_with_key_value(params[0],params[1])
    else
      perform_with_key(params[0])
    end
  end
  ## This method perform a key only value parameter, steps:
  ## 1- Get a transporter object
  ## 2- Write Header
  ## 3- Write body with lenth and marshalled key
  ## 4- Read response, unmarshall it and return it
  def perform_with_key key
    s=@remotecache.get_transporter
		##Send Header
		s.write @header
		##Send Body
		mkey=Marshal.dump(key)
		s.write Unsigned.encodeVint(mkey.size)
		#s.putc mkey.size
		s.write mkey
		#Handle response
		rspHeader = s.read(5)
#		puts "Header " + rspHeader.unpack('c*').to_s
		rspBodyValueLengh = Unsigned.decodeVint(s)
#		puts "Value Lenght " + rspBodyValueLengh.to_s
		rspBodyValue = s.read(rspBodyValueLengh)
		mrspBodyValue = Marshal.load(rspBodyValue)

    @remotecache.release_transporter s
    
		mrspBodyValue
  end
  ## This method perform a key only value parameter, steps:
  ## 1- Set up a socket
  ## 2- Write Header
  ## 3- Write body with:
  ## 3a- Lenght and marshalled key
  ## 3b- lifespanSeconds and maxIdleTimeSeconds (currently missing)
  ## 3c- Lenght and marshalled value
  ## 4- Read and validate response
  def perform_with_key_value key, value
    s=@remotecache.get_transporter
		##Send Header
		s.write @header
		##Send Body
		mkey=Marshal.dump(key)
		s.write Unsigned.encodeVint(mkey.size)
  
#		puts "AAAA1 " + mkey.size.to_s + Unsigned.encodeVint(mkey.size).to_s
		s.write mkey
		s.write [0x00.chr,0x00.chr]
		mvalue=Marshal.dump(value)
		s.write Unsigned.encodeVint(mvalue.size)
		#s.putc mvalue.size
#		puts "AAAA2 " + mvalue.size.to_s
		s.write mvalue
		#Handle response
		rspHeader = s.read(5)
#		puts "Header " + rspHeader.unpack('c*').to_s
    @remotecache.release_transporter s
  end
end