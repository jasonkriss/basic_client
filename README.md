# BasicClient

Helper library for writing faraday-based API wrappers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'basic_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install basic_client

## Usage

```ruby
class StripeClient < BasicClient::Base
  with_base 'https://api.stripe.com'

  def initialize(api_key)
    @api_key = api_key
  end

  def charges
    get('charges')
  end

  private
  attr_reader :api_key

  def path_prefix
    'v1'
  end

  def set_request_middleware(connection)
    connection.request :basic_auth, api_key, ''
  end
end
```

## Contributing

1. Fork it ( https://github.com/jasonkriss/basic_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
