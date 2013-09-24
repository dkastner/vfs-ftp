require 'fake_ftp'

require 'spec_helper'
require 'vfs/ftp'
require 'vfs/drivers/specification'

describe Vfs::FTP do
  before :all do
    puts 'Starting FTP'
    @server = FakeFtp::Server.new 21212 
    @server.start
  end

  after :all do
    @server.stop
  end

  before :each do
    @driver = Vfs::FTP.new host: '127.0.0.1', port: 21212
  end

  it_behaves_like 'vfs driver basic'
  it_behaves_like 'vfs driver attributes basic'
  it_behaves_like 'vfs driver files'
  it_behaves_like 'vfs driver full attributes for files'
  it_behaves_like 'vfs driver query'
  it_behaves_like 'vfs driver full attributes for dirs'
end

