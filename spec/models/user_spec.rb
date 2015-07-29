require "rails_helper"

describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_length_of(:first_name).is_at_least(2) }
  it { should validate_presence_of(:last_name) }
  it { should validate_length_of(:last_name).is_at_least(2) }

  describe '#name' do
    it 'returns first and last name delimited by space' do
      user = build_stubbed(:user, first_name: "Serhiy", last_name: "Topchiy")
      expect(user.name).to eq('Serhiy Topchiy')
    end
  end
end
