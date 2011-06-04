require 'spec_helper'

describe User do
  
  context "creating a new user with an encrypted password" do
    
    it "intitializes an encrypted password when the password is set" do
      user = User.new({ :password => "p@ssword" })
      user.password.should == "p@ssword"
      user.crypted_password.should_not be_nil
      user.crypted_password.should_not == user.password
    end
    
    it "intitializes a salt when the password is set" do
      user = User.new({ :password => "p@ssword" })
      user.salt.should_not be_nil
    end
    
    it "retrieves the cleansed password when the user is created" do
      User.create({ :email => "someone@example.com", :password => "p@ssword" })
      user = User.find(:first)
      user.password.should == "p@ssword"
    end
    
  end
  
  context "authenicating a user" do
    
    it "returns nil if the email and password are invalid" do
      user = User.authenticate("does-not-exist@example.com", "p@ssword1")
      user.should be_nil
    end
    
    it "returns a user record if the email and password are valid" do
      User.create({ :email => "joe@example.com", :password => "p@ssword1" })
      user = User.authenticate("joe@example.com", "p@ssword1")
      user.should_not be_nil
    end
    
    it "returns a user record regardless of the email case" do
      User.create({ :email => "joe@example.com", :password => "p@ssword1" })
      user = User.authenticate("Joe@example.com", "p@ssword1")
      user.should_not be_nil
    end
    
  end
  
  context "validating a user" do
    
    it "should be invalid if the email address is missing" do
      user = User.new({ :email => "" })
      user.should_not be_valid
      user.errors[:email][0].should == "can't be blank"
    end
    
    it "should be invalid if the password is missing" do
      user = User.new({ :password => "" })
      user.should_not be_valid
      user.errors[:password].should == ["can't be blank"]
    end
    
    it "should be invalid if the email is not formatted as an email" do
      user = User.new({ :email => "invalid@.com" })
      user.should_not be_valid
      user.errors[:email].should == ["is invalid"]
    end
    
  end
  
end
