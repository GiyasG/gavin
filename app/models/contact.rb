class Contact < ActiveRecord::Base
  belongs_to :authority
  has_and_belongs_to_many :teams, dependent: :destroy

  validates :city, :presence => true
  validates :street, :presence => true
  validates :email, email_format: { alert: "doesn't look like an email address" }
end
