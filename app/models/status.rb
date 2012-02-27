# == Schema Information
#
# Table name: statuses
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  level       :string(255)
#  image       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Status < ActiveRecord::Base
  validates_presence_of :name, :image
  validates :name, uniqueness: true
  
  attr_accessible :name, :description, :level, :image
 
end
