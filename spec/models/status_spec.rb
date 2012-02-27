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

require 'spec_helper'

describe Status do
  it { should validate_presence_of :name }
  it { should validate_presence_of :image }
end
