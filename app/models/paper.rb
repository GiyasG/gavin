class Paper < ActiveRecord::Base
  belongs_to :authority
  has_and_belongs_to_many :teams, dependent: :destroy
  has_many :photos

  validates :title, :presence => true

end
