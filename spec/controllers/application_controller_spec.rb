require 'spec_helper'

describe ApplicationController do
  describe "#correct_user?" do
    User.should_receive(:find)
    subject.correct_user?
  end
end
