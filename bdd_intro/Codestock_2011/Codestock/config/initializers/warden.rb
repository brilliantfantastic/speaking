Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = SessionsController
end

module RailsWarden
  def self.unauthenticated_action
    "new"
  end
end

# Setup Session Serialization
class Warden::SessionSerializer
  def serialize(record)
    [record.class, record.id]
  end

  def deserialize(keys)
    klass, id = keys
    klass.find(id)
  end
end

Warden::Strategies.add(:password) do
  def valid?
    params[:user][:email] && params[:user][:password]
  end

  def authenticate!
    u = User.authenticate(params[:user][:email], params[:user][:password])
    u.nil? ? fail!("Could not sign in") : success!(u)
  end
end
