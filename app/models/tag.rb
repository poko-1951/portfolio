# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :topics,   through: :taggings

  validates :name, presence: true, length: { maximum: 255 }
end
