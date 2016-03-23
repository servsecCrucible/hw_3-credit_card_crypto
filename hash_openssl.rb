require 'openssl'

def openssl_hash_sha256(plaintext)
  OpenSSL::Digest::SHA256.digest(plaintext).unpack('H*')
end

def openssl_hash_sha1(plaintext)
  OpenSSL::Digest::SHA1.digest(plaintext).unpack('H*')
end

def openssl_hash_md5(plaintext)
  OpenSSL::Digest::MD5.digest(plaintext).unpack('H*')
end
