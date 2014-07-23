require 'spec_helper'

describe User do
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_secure_password }
  it { should ensure_length_of(:password).is_at_least(5)}
  it { should have_many(:reviews) }
  it { should have_many(:queue_items).order("position") }
  it { should have_many(:followships) }
  it { should have_many(:followees).through(:followships) }
  it { should have_many(:followerships).class_name("Followship").
    with_foreign_key("followee_id") }
  it { should have_many(:followers).through(:followerships).source(:user) }

end