require "rails_helper"

describe Article do
  let(:user) { create(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(5) }
  it { should have_many(:comments) }
  it { should belong_to(:user) }

  it 'deletes all comments when article is destroyed' do
    article = create(:article, comments_count: 2)
    expect(Comment.count).to be(2)
    article.destroy

    expect(Comment.count).to be(0)
  end

  describe '#owned_by?' do
    it 'returns true' do
      article = create(:article, user: user)
      expect(article.owned_by?(user)).to be_truthy
    end

    it 'returns false' do
      article = create(:article)
      expect(article.owned_by?(user)).to be_falsy
    end
  end
end