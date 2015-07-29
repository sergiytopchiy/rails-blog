require "rails_helper"

describe "articles/show" do
  let(:user) { build_stubbed(:user) }

  it "displays one article" do
    allow(view).to receive(:user_signed_in?).and_return(false)
    assign(:article, build_stubbed(:article, title: "Super Title", text: "My own text"))

    render

    expect(rendered).to have_selector('h2', text: 'Super Title')
    expect(rendered).to have_selector('.article p', text: 'My own text')
  end

  context "user is signed in" do
    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(user)
    end

    it "displays edit button if current user is owner of article" do
      assign(:article, build_stubbed(:article, user: user))

      render

      expect(rendered).to have_selector('a', text: 'Edit')
    end

    it "doesn't display edit button if current user is not owner of article" do
      assign(:article, build_stubbed(:article))

      render

      expect(rendered).to_not have_selector('a', text: 'Edit')
    end
  end
end
