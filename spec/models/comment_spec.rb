require "rails_helper"

describe Comment do
  let(:user) { build_stubbed(:user) }

  it { should belong_to(:article) }

  describe '#owned_by?' do
    it 'returns true' do
      comment = build_stubbed(:comment, user: user)
      expect(comment.owned_by?(user)).to be_truthy
    end

    it 'returns false' do
      another_user = build_stubbed(:user)
      comment = build_stubbed(:comment, user: another_user)
      expect(comment.owned_by?(user)).to be_falsy
    end
  end
end
