require "rails_helper"

RSpec.describe User do
  let(:user) { build(:user) }

  it { expect(user.name).to match "Test User" }
end
