require 'spec_helper'

describe Event do
  
  let(:status) { FactoryGirl.create(:status) }
  let(:user) { FactoryGirl.create(:user) }
  let(:service) { FactoryGirl.create(:service)} 

  before { user.save }
  
  let!(:service) do 
   FactoryGirl.create(:service, user: user)
  end  
  
  let!(:older_event) do 
        FactoryGirl.create(:event, :service => service, :status => status, :created_at => 1.day.ago)
  end
  
  let!(:newer_event) do 
        FactoryGirl.create(:event, :service => service, :status => status, :created_at => 1.hour.ago)
  end
  
  it "should have the right events in the right order" do
    service.events.should == [newer_event, older_event]
  end
  
end
