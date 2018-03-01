class Authority < ActiveRecord::Base
  has_many :papers, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :photos, dependent: :destroy

  validates :name, :presence => true
  validates :surname, :presence => true
  # validate :file_size_under_one_mb

  accepts_nested_attributes_for :photos


  # def initialize(params = {})
  #   @file = params.delete(:photos_attributes)
  #
  #   super
  #
  #   if @file
  #     self.filename = sanitize_filename(@file[:file].original_filename)
  #     self.content_type = @file[:file].content_type
  #     self.file_contents = @file[:file].read
  #   end
  #
  # end
  #
  # private
  #
  #   def sanitize_filename(filename)
  #     return File.basename(filename)
  #   end
  #
  #   NUM_BYTES_IN_MEGABYTE = 1048576
  #   def file_size_under_one_mb
  #     if (@file.size.to_f / NUM_BYTES_IN_MEGABYTE) > 1
  #       errors.add(:file, 'File size cannot be over one megabyte.')
  #     end
  #   end

end
