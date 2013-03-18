require 'spec_helper'

describe ApplicationController do
  describe "#correct_user?" do
    it "checks if the user is correct" do
      User.should_receive(:find)
      subject.correct_user?
    end
  end
end
