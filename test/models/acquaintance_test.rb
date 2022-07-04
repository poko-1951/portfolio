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
require "test_helper"

class AcquaintanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
