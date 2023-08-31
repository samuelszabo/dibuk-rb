module Dibuk
  class User
    extend Dry::Initializer::Mixin

    option :id
    option :email
    option :name
    option :surname

  end
end