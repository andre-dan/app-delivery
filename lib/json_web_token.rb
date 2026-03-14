require "jwt"

module JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base || ENV.fetch("SECRET_KEY_BASE")
  ACCESS_TTL  = 24.hours
  REFRESH_TTL = 30.days

  def self.encode(payload, ttl: ACCESS_TTL)
    payload = payload.merge(exp: ttl.from_now.to_i)
    JWT.encode(payload, SECRET_KEY, "HS256")
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, algorithm: "HS256")
    HashWithIndifferentAccess.new(decoded.first)
  rescue JWT::DecodeError => e
    raise e
  end

  def self.encode_refresh(user_id)
    encode({ user_id: user_id, type: "refresh" }, ttl: REFRESH_TTL)
  end

  def self.encode_access(user_id)
    encode({ user_id: user_id, type: "access" }, ttl: ACCESS_TTL)
  end
end
