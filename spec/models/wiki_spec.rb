require 'rails_helper'

RSpec.describe Wiki, type: :model do
	let(:user) { create(:user) }
	let(:premium_user) { create(:user, role: "premium") }
	let(:admin) { create(:user, role: "admin") }
	let(:wiki) { create(:wiki, user: user) }
	let(:private_wiki) { create(:wiki, private: true, user: premium_user) }


	# Shoulda tests for user
	it { should belong_to(:user) }
	it { should validate_presence_of(:user) }

	# Shoulda tests for title
	it { should validate_presence_of(:title) }
	it { should validate_length_of(:title).is_at_least(5) }
	
	# Shoulda tests for body
	it { should validate_presence_of(:body) }
	it { should validate_length_of(:body).is_at_least(20) }

	describe "attributes" do
		it "should respond to title" do
			expect(wiki).to respond_to(:title)
		end

		it "should respond to body" do
			expect(wiki).to respond_to(:body)
		end

		it "should respond to user" do
			expect(wiki).to respond_to(:user)
		end
	end

	describe "#public?" do
		it "should return true for public wikis" do
			expect(wiki.public?).to be_truthy
		end

		it "should return false for private wikis" do
			expect(private_wiki.public?).to be_falsy
		end
	end
end
