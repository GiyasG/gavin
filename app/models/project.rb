class Project < ActiveRecord::Base
  belongs_to :authority
  has_and_belongs_to_many :teams, :dependent => :destroy
  has_many :photos

  validates :title, :presence => true

  accepts_nested_attributes_for :photos

  def self.search(search)
    where("title LIKE ? or about LIKE ?", "%#{search}%", "%#{search}%")
  end

end
