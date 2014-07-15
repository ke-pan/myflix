require 'spec_helper'

describe Review do

  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:rate) }
  it { should validate_presence_of(:description) }
  it { should ensure_inclusion_of(:rate).in_range(1..5) }
  
end