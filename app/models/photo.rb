class Photo < ActiveRecord::Base
  belongs_to :authority
  belongs_to :paper
  belongs_to :project
  has_and_belongs_to_many :teams

  validates :description, :presence => true
  validate :file_size_under_one_mb if @file.present?

  scope :no_ids, -> { where(:authority_id=>nil, :project_id=>nil, :paper_id=>nil) }

  def initialize(params = {})
    @file = params.delete(:file)

    super
    if @file

      @image = MiniMagick::Image.open(@file.path)
      @image.resize "350x350"

      self.filename = sanitize_filename(@file.original_filename)
      self.content_type = @file.content_type
      self.file_contents = @image.to_blob
      # binding.pry
    end
  end

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
