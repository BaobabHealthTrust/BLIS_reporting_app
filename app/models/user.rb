class User < ActiveRecord::Base
  self.table_name = 'user'

  def password_matches?(plain_password)
    not plain_password.nil? and self.password == validate_password(plain_password)
  end

  def validate_password(plain_password)
    Digest::SHA1.hexdigest(plain_password + "This comment should suffice as salt.")
  end

  def name
    person = self.person
    "#{person.first_name} #{person.last_name}"
  end

end
