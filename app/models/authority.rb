class Authority < ActiveRecord::Base
  has_many :papers, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :photos, dependent: :destroy

  validates :authority_name, :presence => true
  validates :authority_surname, :presence => true
end
