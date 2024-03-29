class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>"}
  validates_attachment_content_type :image, :content_type =>
    ["image/jpg", "image/jpeg", "image/png"]
    # ask linda about Attachment model later

  def tag_list
    tags.collect {|tag| tag.name}.join(", ")
    # shows <Tag:bunchohex> in the edit form without collecting the names first
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect { |tag| tag.strip.downcase }.uniq

    new_or_found_tags = tag_names.collect do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end

    self.tags = new_or_found_tags
  end

  def to_s
    name
  end
end
