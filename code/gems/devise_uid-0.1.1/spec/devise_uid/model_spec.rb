require 'spec_helper'

class User < ActiveRecord::Base
  devise :uid
end

describe User do
  it "generates uid before save" do
    user = User.create!(:email => "foo@bar.com")
    user.uid.should be
  end

  it "doesn't generate uid if it has it" do
    user = User.create!(:email => "foo@bar.com")
    uid = user.uid

    user.update_attributes(:email =>"bar@baz.com")
    user.uid.should == uid
  end
end
