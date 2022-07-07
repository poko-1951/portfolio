# == Schema Information
#
# Table name: acquaintances
#
#  id           :integer          not null, primary key
#  character    :string           default("未設定"), not null
#  like         :string           default("未設定"), not null
#  name         :string           not null
#  relationship :string           default("未設定"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_acquaintances_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Acquaintance < ApplicationRecord
  belongs_to :user
  has_many   :stocks,    dependent: :destroy
  has_many   :schedules, dependent: :destroy
  has_many   :events,    through: :schedules
  has_many   :topics,    through: :stocks

  has_one_attached :acquaintance_image

  def get_acquaintance_image
    unless acquaintance_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpeg")
      acquaintance_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    acquaintance_image
  end

end
