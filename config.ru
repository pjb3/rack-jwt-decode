require_relative "lib/rack_jwt_decode"

app = lambda do |env|
  [
    200,
    { "Content-Type" => "application/json" },
    [JSON.generate(env.reject{|k, _| ["rack.input", "rack.errors"].include?(k) })]
  ]
end

use RackJWTDecode, "secret"
run app
