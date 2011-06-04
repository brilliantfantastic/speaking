require 'openssl'

module Crypt
  def encrypt(key)
    cipher = build_cipher(:encrypt, key)
    [cipher.update(self) + cipher.final].pack('m').chomp
  end
  
  def decrypt(key)
    cipher = build_cipher(:decrypt, key)
    cipher.update(self.unpack('m')[0]) + cipher.final
  end
  
  private
    def build_cipher(type, password) #:nodoc:
      cipher = OpenSSL::Cipher::Cipher.new("DES-EDE3-CBC").send(type)
      cipher.pkcs5_keyivgen(password)
      cipher
    end
end

class String
  include Crypt
end