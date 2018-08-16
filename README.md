# LenovoSupport

Wrapper for the Lenovo Support API. Also includes a console for direct queries.

## Installation
Change directory to project directory and install dependencies:
    
    $ bundle install
    
### Installation as a gem

Add this line to your application's Gemfile:

```ruby
gem 'LenovoSupport'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install LenovoSupport

## Usage

### Console
You can query for information using the included console application.
Try calling the console with the argument, 'help'
#### Windows - Powershell
Creates a new Powershell profile

    new-item $PROFILE.CurrentUserAllHosts -ItemType file -Force
Add the following to the file

    set-alias lencon Call-LenovoSupportConsole
    function Call-LenovoSupportConsole { ruby <path to project>/lib/LenovoSupportConsole/console.rb $args }


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
