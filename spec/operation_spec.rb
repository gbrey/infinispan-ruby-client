require '../lib/infinispan-ruby-client.rb'

describe "Operation" do
  before(:each) do
    @remotecache=RemoteCache.new
    @transporter=Array.new
    @remotecache def get_transporter
      @transporter
    end
    @op = Operation.new(@remotecache)
  end
	context "Header handling" do
    it "It writes the header that was previously injected" do
      header=['1','2','3','4','5']
      @op.header=header
      @op.perform "key", "value"
      written_header=@transporter.get(@op.header.size)
      written_header.should.size == 5
      written_header.should == header
		end
	end
end
