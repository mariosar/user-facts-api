require 'rails_helper'

RSpec.describe User, type: :model do
	subject { described_class.new(
		username: "test",
		password: "secret"
	) }

	it "should have many facts" do
		expect(User.reflect_on_association(:facts).macro).to eq(:has_many)
	end

	it "is valid with valid attributes" do
		expect(subject).to be_valid
	end

	it "is invalid without a username" do
		subject.username = nil
		
		expect(subject).to_not be_valid
	end

	it "is invalid without a password" do
		subject.password = nil

		expect(subject).to_not be_valid
	end
end
