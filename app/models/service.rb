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

class Service < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :statuses, :through => :events
  
  attr_accessible :name, :description ,:url
  
  validates_presence_of :user_id, :name, :description
  validates_length_of :name, :maximum => 50
  validates_length_of :description, :maximum => 300
  
  #use default scope to fetch services in reverse chronological order
  default_scope order: 'services.created_at DESC'

  def status_at(date, days_before=1)
    event=self.events.where("created_at <= ? AND created_at > ?", 
                            (date+1).to_time.utc, (date-days_before+1).to_time.utc).first
    if event.nil? and days_before<=5
      return self.status_at(date, days_before+1)
    end
    event ? event.status.image : nil
  end
end
