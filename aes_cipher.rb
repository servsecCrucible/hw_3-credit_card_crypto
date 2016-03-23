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
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key = Digest::SHA1.hexdigest(key.to_s)
	iv = cipher.random_iv
	encrypted = cipher.update(document.to_s) + cipher.final
    [iv, encrypted]	
  end

  def self.decrypt(aes_crypt, key)
    # TODO: decrypt from JSON output (aes_crypt) of encrypt method above
    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    decipher.key = Digest::SHA1.hexdigest(key.to_s)
    decipher.iv = aes_crypt[0]
    original = decipher.update(aes_crypt[1].to_s) + decipher.final
 
  end
end
