require "rails_helper"

describe ApplicationHelper do

  describe "#navbar_link" do
    it "it returns active if current page is article" do
      allow(helper).to receive(:params).and_return(controller: 'articles')
      result = helper.navbar_link('articles')
      expect(result).to eq('active')
    end

    it "it returns empty string if current page is not article" do
      allow(helper).to receive(:params).and_return(controller: 'comments')
      result = helper.navbar_link('articles')
      expect(result).to eq('')
    end
  end
end