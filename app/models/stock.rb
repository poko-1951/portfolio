class Stock < ApplicationRecord
  belongs_to :acquaintance
  belongs_to :user
  belongs_to :topic
end
