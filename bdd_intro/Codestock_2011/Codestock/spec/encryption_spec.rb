require File.dirname(__FILE__) + "/../config/initializers/encryption"

describe String do
  
  context "encrypting a string" do
    it "a string can be encrypted with a private key" do
      encrypted = "This is a test".encrypt("some key")
      encrypted.should_not be_nil
      encrypted.should_not == "This is a test"
    end
  end
  
  context "decrypting a string" do
    it "a string can be decrypted with the same private key it was encrypted with" do
      encrypted = "This is a test".encrypt("some key")
      decrypted = encrypted.decrypt("some key")
      decrypted.should == "This is a test"
    end
  end
  
end