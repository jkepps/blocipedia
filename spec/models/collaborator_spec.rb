require 'rails_helper'

RSpec.describe Collaborator, type: :model do
	let(:user) { create(:user) }
	let(:other_user) { create(:user) }
	let(:wiki) { create(:wiki) }
	let(:collaborator) { create(:collaborator, user: other_user, wiki: wiki) }

	it { should belong_to(:user) }
	it { should belong_to(:wiki) }
end
