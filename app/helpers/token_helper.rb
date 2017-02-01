require 'devise'

module TokenHelper
  class TokenGenerator
    def self.generate(size = 32)
      require 'securerandom'
      random_string = SecureRandom.hex(size)
    end
  end
end
