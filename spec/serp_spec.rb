require 'spec_helper'
describe Serp do
  describe "#rank" do
    it "should return 30 urls" do
      Serp.rank('rank').size.should == 30
    end
  end
end