# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  # Creates a test user
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                           password: "foobar", password_confirmation: "foobar");
  end
  # makes the user object the default test subject
  subject { @user }

  it { should respond_to(:name); }
  it { should respond_to(:email); }
  it { should respond_to(:password_digest); }
  it { should respond_to(:password); }
  it { should respond_to(:password_confirmation); }
  it { should respond_to(:authenticate); }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " "; }
    # in rspec, whenever there is an object that responds to
    # the method "foo?" there will be a corresponding test method that
    # called "be_foo"
    it { should_not be_valid; }
  end
 
  describe "when email is not present" do
    before {@user.email = " ";}
    # At this point the user name is back to the larger scope and now we have
    # blanked out the email
    it {should_not be_valid; }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51; }
    it { should_not be_valid; }
  end

  # Email format testing

  # Invalid email addresses
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@food,com user_at_foo.org example.user@foo.
                      foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address;
        @user.should_not be_valid;
      end
    end
  end

  # Valid email addresses
  describe "when email format is nvalid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address;
        @user.should be_valid;
      end
    end
  end

  # Email address uniqueness
  describe "when email address is already taken" do
    before do
      # Make a duplicate email and try to save it
      user_with_same_email = @user.dup();
      # Changes the case of the email address to make sure
      # that the email addresses are also case insensitive
      user_with_same_email.email = @user.email.upcase();
      user_with_same_email.save();
    end

    # Confirm that it is invalid
    it { should_not be_valid }
  end

  # Checking password presence validation and playing around with block
  # delcaration syntax
  describe "when password is not present" do
    before do
      # Note: This is ONLY testing presences since both password and
      # password confirmation are set to the same " "
      @user.password = @user.password_confirmation = " ";
    end
    it do should_not be_valid; end
  end

  # Check password confirmation
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch"; }
    it { should_not be_valid; }
  end

  # ONE MORE CASE: password confirmation is "nil" (possible at the console
  # and not on the web, but we should still account for it)

  describe "when passsword confirmation is nil" do
    before { @user.password_confirmation = nil; }
    it { should_not be_valid; }
  end

  # Testing user authentication
  describe "return value of authenticate method" do
    before { @user.save }
    # Sets the found_user symbol to holder the user we saved
    let(:found_user) { User.find_by_email(@user.email) }
    
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      # Let sets a variable value of the passed in smybol to to the value returned
      # from the passed in block
      # It uses memoization to avoid repeated function calls for computation of
      # equivalent values
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      # Specify is just a synonym for "it" used for better semantics
      # (that is Ruby culture for you!)
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "with a password that's too short - shorter than 6 characters" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

end
