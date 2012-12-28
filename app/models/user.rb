# The commenting is created with
# bundle exec annotate (using the annotate gem)
# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible(:email, :name, :password, :password_confirmation);

  # Active record callback that we can use to 
  # set the email to lowercase before saving
  before_save { |user| user.email = email.downcase(); }

  validates(:name, presence: true, length: { maximum: 50 } );
  
  # regex notes;
  # \A matches the beginning of a string
  # w+ matches word characters
  # .  maches any character execep new line
  # \z matches end of string
  # i  at the end means ignore case when matching text

  # Capital starting letter means it is a constant (this also means that class
  # name declarations are constants)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: {case_sensitive: false};

  # IMPORTANT: Because of race conditions, uniqueness needs to be supported on
  # the database side as well through creating a new migration:
  #
  # rails generate migration add_index_to_users_email
  
  validates(:password, presence: true, length: { minimum: 6 });
  validates :password_confirmation, presence: true;

  # As long as password_digest is defined in a database migration
  # the has_secure_password method takes care of:
  #
  # 1) attr_accessor :password
  # 2) confirmation validator on password
  # 3) presence validator on password_digest
  # 4) when password is set password_digest is encrypted 
  #    using bcrypt-ruby
  # 5) authenticate takes one argument of an unencrypted password. 
  # The unencrypted password will be encrypted and compared to the password_digest. 
  # If the two match self is returned. If the match fails false is returned.
  # Source: http://bcardarella.com/post/4668842452/exploring-rails-3-1-activemodel-securepassword
  # and:    https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
  has_secure_password;

end
