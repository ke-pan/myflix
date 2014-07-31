require 'spec_helper'

describe Invitation do
  
  it { should belong_to(:user) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email).scoped_to(:user_id).
        with_message("Have invited him/her already") }

  describe "generate_token" do
    it "generates a token when create" do
      invitation = Fabricate(:invitation)
      expect(invitation.token).to be_present
    end
  end

end