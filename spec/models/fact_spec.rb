require 'rails_helper'

RSpec.describe Fact, type: :model do
	let (:user) { User.create(username: "test", password: "secret") }

	subject { described_class.new(
		user_id: user.id,
		fact: "Cephalopods communicate by changing colors",
		likes: 2
	) }

	it "should belong to user" do
		expect(Fact.reflect_on_association(:user).macro).to eq(:belongs_to)
	end

	it "is valid with valid attributes" do
		expect(subject).to be_valid
	end

	it "is invalid without a fact" do
		subject.fact = ""

		expect(subject).to_not be_valid
	end

	it "is invalid without likes" do
		subject.likes = nil

		expect(subject).to_not be_valid
	end

	it "is invalid if likes is not greater than or equal to 0" do
		subject.likes = -3

		expect(subject).to_not be_valid
	end
end
