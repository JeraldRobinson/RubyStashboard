# == Schema Information
#
# Table name: events
#
#  id         :integer         not null, primary key
#  message    :string(255)
#  service_id :integer
#  created_at :datetime
#  updated_at :datetime
#  status_id  :integer
#

class Event < ActiveRecord::Base
  belongs_to :status
  belongs_to :service


  validates_presence_of :service_id, :status_id, :message
  
  attr_accessible :message, :service_id, :status_id
  
  default_scope order: 'events.created_at DESC'

  private
  
  scope :recent, order("created_at DESC").limit(5)
  
end
