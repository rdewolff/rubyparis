require 'digest/md5'
class Hashpw
  
  def encrypt_password
    self.password = encrypt(self.password)
  end
  
  def self.encrypt(word)
    return Digest::SHA1.hexdigest(word)
  end
  
  def encrypt(password)
    salt = self.class.generateSalt(2)
    crypted_password = self.class.encrypt(salt+password)
    return salt + crypted_password
  end
  
  def self.generateSalt(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    return Array.new(len){||chars[rand(chars.size)]}.join
  end
  
  def authenticate(crypted_password, password)
    salt = crypted_password[0..1]
    new_crypted_password = salt + self.class.encrypt(salt+password)
    return new_crypted_password == crypted_password
  end
  
end