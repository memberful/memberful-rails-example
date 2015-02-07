require "rails_helper"

RSpec.describe Administrator, type: :model do
  let(:administrator) { build(:administrator) }

  it { expect(administrator.email).to match(/@example.com/) }
end
