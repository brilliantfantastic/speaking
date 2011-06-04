class User < ActiveRecord::Base
  validates_presence_of :email, :password
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  def password=(clean)
    @password = clean
    encrypt_password
  end
  
  def password
    return @password unless @password.blank?
    @password = cleansed_password
  end
  
  def self.authenticate(email, password)
    user = first(:conditions => ["lower(email) = ?", email.downcase]) if email.present?
    user && user.password == password ? user : nil
  end
  
  private
  
  def encrypt_password
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
    if @password.blank?
      self.crypted_password = @password
    else
      self.crypted_password = @password.encrypt(self.salt)
    end
  end
  
  def cleansed_password
    return if crypted_password.blank? || salt.blank?
    crypted_password.decrypt(salt)
  end
  
end
