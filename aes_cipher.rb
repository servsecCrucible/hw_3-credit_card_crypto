require 'openssl'
require 'base64'
require 'json'
require 'digest/sha1'

module AesCipher
  def self.encrypt(document, key)
    # TODO: Return JSON string of array: [iv, ciphertext]
    #       where iv is the random intialization vector used in AES
    #       and ciphertext is the output of AES encryption
    # NOTE: Use base64 for ciphertext so that it is screen printable
    #       Use cipher block chaining mode only!
    
    cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    cipher.encrypt
    
    cipher.key = Digest::SHA1.hexdigest(key.to_s)
    iv = cipher.random_iv
    cipher.iv = iv 
    
    crypt_blocks = document.map do |item|
    	cipher.update(item.to_s)
    end
    
    encrypted = crypt_blocks << cipher.final
    encrypted = encrypted.to_s
    [iv, encrypted].to_json	
  end

  def self.decrypt(aes_crypt, key)
    # TODO: decrypt from JSON output (aes_crypt) of encrypt method above

 
  end
end
