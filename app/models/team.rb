class Team < ActiveRecord::Base
  has_and_belongs_to_many :papers
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :contacts, dependent: :destroy
  has_and_belongs_to_many :photos, dependent: :destroy

  validates :name, :presence => true
  validates :surname, :presence => true

  accepts_nested_attributes_for :photos

  def name_with_initial
    "#{title} #{name} #{surname}"
  end

end
