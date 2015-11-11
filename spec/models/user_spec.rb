require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { create(:user) }

	it { should have_many(:wikis) }
	it { should have_many(:wikis).through(:collaborators) }

	it { should validate_presence_of(:username) }
	it { should validate_length_of(:username).is_at_least(4) }
	it { should validate_uniqueness_of(:username) }

	describe "attributes" do
		it "should respond to username" do
			expect(user).to respond_to(:username)
		end
	end
end
