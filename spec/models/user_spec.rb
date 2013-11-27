require 'spec_helper'

describe User do
  describe "creating users" do
    it "has a valid factory" do
      FactoryGirl.create(:user).should be_valid
    end

    it "is valid to create multiple with valid users" do
      FactoryGirl.create(:user).should be_valid
      FactoryGirl.create(:user, username: "rhintz43", email: "rhintz43@stanford.edu").should be_valid
    end

    context "password field" do
      context "use build" do
        it "is invalid without a password" do
          FactoryGirl.build(:user, password: "").should_not be_valid
        end
      end
      
      context "use create" do
        it "is invalid without a password" do
          expect {
            FactoryGirl.create(:user, password: "")
          }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context "password_confirmation field" do
      context "use build" do
        it "is invalid without a password_confirmation" do
          FactoryGirl.build(:user, password_confirmation: "").should_not be_valid
        end
      end

      context "use create" do
        it "is invalid without a password_confirmation" do
          expect {
            FactoryGirl.create(:user, password_confirmation: "")
          }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context "email field" do
      context "use build" do
        it "is invalid without an email" do
          FactoryGirl.build(:user, email: "").should_not be_valid
        end

        it "is invalid if 2 emails are the same" do
          FactoryGirl.create(:user)
          
          FactoryGirl.build(:user, username: "rhintz43").should_not be_valid
        end
      end

      context "use save" do
        it "is invalid without an email" do
          expect {
            FactoryGirl.create(:user, email: "")
          }.to raise_error(ActiveRecord::RecordInvalid)
        end

        it "is invalid if 2 emails are the same" do
          user = FactoryGirl.create(:user)
          
          expect {
            FactoryGirl.create(:user, username: "rhintz43")
          }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context "username field" do
      context "use build" do
        it "is invalid without a username" do
          FactoryGirl.build(:user, username: "").should_not be_valid
        end

        it "is invalid if 2 usernames are the same" do
          FactoryGirl.create(:user)
          
          FactoryGirl.build(:user, email: "hello@stanford.edu").should_not be_valid
        end
      end

      context "use save" do
        it "is invalid without a username" do
          expect {
            FactoryGirl.create(:user, username: "")
          }.to raise_error(ActiveRecord::RecordInvalid)
        end

        it "is invalid if 2 usernames are the same" do
          FactoryGirl.create(:user)
          
          expect {
            FactoryGirl.create(:user, email: "hello@stanford.edu")
          }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
    
    context "description field" do
      it "is valid if it doesn't have a description" do
        FactoryGirl.create(:user, description: "").should be_valid
      end
    end
  end

  describe "filter username by prefix" do
    before :each do
        @rhintz42 = FactoryGirl.create(:user)
        @rhintz43 = FactoryGirl.create(:user, username: "rhintz43", email: "rhintz43@stanford.edu")
        @billy = FactoryGirl.create(:user, username: "billy", email: "billy@gmail.com")
    end
    
    context "matching letters" do
      it "returns a sorted array of results that match, 1 letter" do
        users = User.by_prefix("r")
        users.should == [@rhintz42, @rhintz43]
      end
      
      it "returns a sorted array of results that match, prefix" do
        users = User.by_prefix("rhi")
        users.should == [@rhintz42, @rhintz43]
      end
      
      it "returns a sorted array of results that match, last letters" do
        users = User.by_prefix("ly")
        users.should == [@billy]
      end
      
      it "returns an empty array on no-prefix" do
        users = User.by_prefix("")
        users.should == []
      end
    end

    context "non-matching letters" do
      it "returns a sorted array of results that match, last letters" do
        users = User.by_prefix("rhi")
        users.should_not include @billy
      end
    end
  end
end
