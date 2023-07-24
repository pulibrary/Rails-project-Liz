# frozen_string_literal: true
require "rails_helper"

describe "accessibility", type: :feature, js: true do
  # let(:user1) { FactoryBot.create(:user) }
  # let(:user1_id) {user1.id}
  context "home page" do
    before do
      visit "/"
    end

    it "complies with wcag" do
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa)
    end
  end

  context "authenticate page" do
    before do
      visit "localhost:3000/authenticate"
    end
    it "complies with wcag2aa wcag21a" do
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa)
    end
  end

  context "profile page" do
    before do
      # user1 = FactoryBot.create(:user)
      # user1_id = user1.id
      visit "localhost:3000/access_profile?user_id=#{user1_id}"
    end

    it "complies with wcag" do
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa)
    end
  end

  context "edit profile page" do
    before do
      visit "localhost:3000/users/#{user1_id}/edit"
    end

    it "complies with wcag" do
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa)
    end
  end

  context "create account page" do
    before do
      visit "localhost:3000/create_account"
    end

    it "complies with wcag" do
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa)
    end
  end

  context "score board page" do
    before do
      visit "localhost:3000/scoreboard"
    end

    it "complies with wcag" do
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa)
    end
  end

  context "list of players page" do
    before do
      visit "localhost:3000/list_players"
    end

    it "complies with wcag" do
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa)
    end
  end
end