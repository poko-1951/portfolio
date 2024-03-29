# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  email                      :string           default("")
#  email_receiving_activation :boolean          default(TRUE), not null
#  encrypted_password         :string           default("")
#  is_deleted                 :boolean          default(FALSE), not null
#  name                       :string           default("")
#  remember_created_at        :datetime
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { "password" }
    password_confirmation { "password" }
  end
end
