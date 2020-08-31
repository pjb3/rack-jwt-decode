require "jwt"

class RackJWTDecode
  HTTP_AUTHORIZATION = "HTTP_AUTHORIZATION".freeze
  BEARER_REGEXP = /\ABearer /i.freeze

  def initialize(app, application_secret)
    @app = app
    @application_secret = application_secret
  end

  def call(env)
    add_jwt_payload_to_env(env)
    @app.call(env)
  end

  private

  def add_jwt_payload_to_env(env)
    return unless @application_secret
    return unless auth = env[HTTP_AUTHORIZATION]
    return unless token = auth.split(BEARER_REGEXP)&.last
    return unless payload = JWT.decode(token, @application_secret)&.first

    payload&.each do |k, v|
      env["jwt.#{k}"] = v
    end
  end
end
