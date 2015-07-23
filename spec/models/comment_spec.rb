require "rails_helper"

describe Comment do
  let(:user) { create(:user) }

  it { should belong_to(:article) }

  describe '#owned_by?' do
    it 'returns true' do
      comment = create(:comment, user: user)
      expect(comment.owned_by?(user)).to be_truthy
    end

    it 'returns false' do
      another_user = create(:user)
      comment = create(:comment, user: another_user)
      expect(comment.owned_by?(user)).to be_falsy
    end
  end
end