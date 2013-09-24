# Vfs::Ftp

This is an FTP driver for the [vfs gem][https://github.com/alexeypetrushin/vfs].

## Installation

Add this line to your application's Gemfile:

    gem 'vfs-ftp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vfs-ftp

## Usage

``` ruby 
require 'vfs/ftp'

system = Vfs::FTP.new host: 'example.com', port: 2121,
  username: 'me', password: 'secret'

system.write '/motd.txt' do |stream|
  stream.write 'test test'
end

puts system.read '/motd.txt'

#=> test test
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
