class Photo < ActiveRecord::Base
  belongs_to :authority
  belongs_to :paper
  belongs_to :project
  has_and_belongs_to_many :teams

  validates :description, :presence => true
  validate :file_size_under_one_mb if @file.present?

  def initialize(params = {})
    # binding.pry
    @file = params.delete(:file)
    # return if @file.nil?

    # binding.pry
    super
    if @file
      self.filename = sanitize_filename(@file.original_filename)
      self.content_type = @file.content_type
      self.file_contents = @file.read
    end
  end

        # def uploaded_file=(incoming_file)
        #   self.filename = incoming_file.original_filename
        #   self.content_type = incoming_file.content_type
        #   self.data = incoming_file.read
        # end
        #
        # def filename=(new_filename)
        #   write_attribute("filename", sanitize_filename(new_filename))
        # end

  private

    def sanitize_filename(filename)
      # Get only the filename, not the whole path (for IE)
      # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
      return File.basename(filename)
    end

    NUM_BYTES_IN_MEGABYTE = 1048576
    def file_size_under_one_mb
      if (@file.size.to_f / NUM_BYTES_IN_MEGABYTE) > 1
        errors.add(:file, 'File size cannot be over one megabyte.')
      end
    end

end
