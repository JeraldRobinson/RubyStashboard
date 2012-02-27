# == Schema Information
#
# Table name: services
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  name        :string(255)
#  description :string(255)
#  url         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Service do

  let(:user) { FactoryGirl.create(:user) }
  before { @service = user.services.build(name: "Service", 
                                          description: "Lorem ipsum",
                                          url: "http://www.example.com/" ) }

  subject { @service }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:url) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @service.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "when description is null or empty" do
    before { @service.description = " " }
    it { should_not be_valid }
  end

  describe "when the description is longer than 300 chars" do
    before { @service.description = "a" * 301 }
    it { should_not be_valid }
  end
end
