class Authority < ActiveRecord::Base
  has_many :papers, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :photos, dependent: :destroy

  validates :name, :presence => true
  validates :surname, :presence => true

  accepts_nested_attributes_for :photos

end
