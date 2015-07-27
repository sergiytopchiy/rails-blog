require "rails_helper"

describe "Welcome" do
  it "displays the user's username after successful login" do
    user = create(:user, email: "sergiy@ukr.net", password: "12345678")
    visit "/"
    expect(page).to have_selector('.jumbotron h1', text: 'Welcome on SeregaBlog')
    click_link "Sign in"
    fill_in "user_email", with: "sergiy@ukr.net"
    fill_in "user_password", with: "12345678"
    click_button "Sign in"

    expect(page).to have_selector(".navbar-text", text: "Signed in as #{user.first_name} #{user.last_name}")
  end
end
