# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag_id     :integer          not null
#  topic_id   :integer          not null
#
# Indexes
#
#  index_taggings_on_tag_id    (tag_id)
#  index_taggings_on_topic_id  (topic_id)
#
# Foreign Keys
#
#  tag_id    (tag_id => tags.id)
#  topic_id  (topic_id => topics.id)
#
require "test_helper"

class TaggingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
