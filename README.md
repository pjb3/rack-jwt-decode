# Rack JWT Decode

This is a Rack middleware that will look for a [JSON Web Token (JWT)](https://jwt.io) in the Authorization Bearer header and if it is present, decode it and add the values from the payload to the Rack env, with the Rack env key prefixed with `"jwt."`.

For example, say your application generated a JWT like this:

    >> token = JWT.encode({ sub: 1234, iat: Time.now.utc.to_i }, "secret")
    => "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyMzQsImlhdCI6MTU5ODg5ODc3Mn0.MOaM22JkvCi2Bg-vUXAPuYXA9NtsApGNDplRdYMYerw"

Now say that clients pass that token back in an HTTP Header like this:

    Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyMzQsImlhdCI6MTU5ODg5ODc3Mn0.MOaM22JkvCi2Bg-vUXAPuYXA9NtsApGNDplRdYMYerw

This middleware would then result in the following additions to the Rack env:

    env["jwt.sub"] # => 1234
    env["jwt.iat"] # => 1598898472

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-jwt-decode'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rack-jwt-decode

## Usage

Configure your Rack application to use this middleware in your Rackup file like this:

    use RackJWTDecode, "secret"

The second argument is the secret key that you used to encode the JWT token.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pjb3/rack-jwt-decode.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
