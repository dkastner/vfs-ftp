require 'net/ftp'
require 'tempfile'

require "vfs/ftp/version"

module Vfs
  class FTP
    MONTHS = %w{Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec}

    attr_accessor :host, :port, :username, :password

    def initialize(options = {})
      self.host = options[:host]
      self.port = options[:port] || Net::FTP::FTP_PORT
      self.username = options[:username]
      self.password = options[:password]
    end

    def connection
      return @connection unless @connection.nil?

      @connection = Net::FTP.new
      @connection.connect host, port
      if username
        @connection.login username, password.to_s 
      else
        @connection.login
      end

      @connection
    end

    def open(&blk)
      blk.call self if blk
    end

    def local?
      false
    end

    def create_dir(path)
      connection.mkdir(path)
    end

    def delete_dir(path)
      connection.rmdir path
    end

    def delete_file(path)
      connection.delete path
    end

    def write_file(remote_path, append = false, &blk)
      connection.resume = append

      str = StringIO.new
      blk.call str
      str.rewind
      file = Tempfile.new 'upload'
      file.write str.to_s
      file.close
      connection.put file.path, remote_path
      file.unlink
    end

    def read_file(remote_path, &blk)
      connection.get remote_path, nil do |data|
        blk.call data.read
      end
    end

    def attributes(path)
      output = connection.ls(path)
      output = output.first if output.respond_to?(:first)
      if output
        perms, _, user, group, size, mon, day, time_or_year, type = output.split(/\s+/)
        attrs = {}
        month = MONTHS.index(mon) + 1
        if time_or_year =~ /:/
          attrs[:created_at] = Time.new(Time.now.year, month, day.to_i)
        else
          attrs[:created_at] = Time.new(time_or_year.to_i, month, day.to_i)
        end
        attrs[:updated_at] = attrs[:created_at]
        attrs[:file] = (type == 'file')
        attrs[:dir] = (type != 'file')
        attrs
      end
    end
  end
end
