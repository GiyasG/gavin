class Photo < ActiveRecord::Base
  belongs_to :authority
  belongs_to :paper
  belongs_to :project
end
