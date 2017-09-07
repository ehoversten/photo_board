class Pin < ApplicationRecord
  has_attached_file :image, styles: {
    instagram: "640x640>",
    large: "500x500>",
    medium: "300x300>",
    thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  belongs_to :user
  validates :user_id, presence: true
end
