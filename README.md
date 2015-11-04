# Amsa::Mason


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amsa-mason'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install amsa-mason

## Usage

Model needs to have a method that points to its parent. Can piggyback on the existing relations directly there or redefine them. (For `up`.)

Serializer needs to have a templates method that returns an Array of Hashes. Some key/value pairs can be inferred in the Adapter, others must be specified in the Serializer. Not all are yet supported.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## TODO
- [fully cover all control properties](https://github.com/JornWildt/Mason/blob/master/Documentation/Mason-draft-2.md#control-properties)

## Contributing

Bug reports and pull requests are welcome on [github](https://github.com/mooreniemi/amsa-mason). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

