require 'rails_helper'

RSpec.describe "Facts", type: :request do
	let (:user) { User.create(username: "test", password: "secret") }

	def post_fact(fact)
		headers = {'CONTENT-TYPE' => 'appliccation/json', 'ACCEPT' => 'application/json'}
		post "/api/v1/facts", :params => {:fact => fact}, as: :json
		expect(response.status).to eq(201)

		parsed = JSON.parse(response.body)
		expect(parsed).to include('id' => a_kind_of(Integer))
		fact.merge('id' => parsed['id'], 'created_at' => parsed['created_at'], 'updated_at' => parsed['updated_at'])
	end

	it "Manages Facts" do
		fact_1 = post_fact({
			'fact' => "Cephalopods communicate by changing colors",
			'user_id' => user.id,
			'likes' => 0
		})

		fact_2 = post_fact({
			'fact' => "Octopuses have three hearts",
			'user_id' => user.id,
			'likes' => 3
		})

		get "/api/v1/facts"
		expect(response.status).to eq(200)

		facts = JSON.parse(response.body)
		expect(facts).to contain_exactly(fact_1, fact_2)
	end

	it "Gets a Fact" do
		fact_1 = post_fact({
			'fact' => "Cephalopods communicate by changing colors",
			'user_id' => user.id,
			'likes' => 0
		})

		get "/api/v1/facts/#{fact_1['id']}"
		expect(response.status).to eq(200)

		parsed = JSON.parse(response.body)
		expect(parsed).to eq(fact_1)
	end

	it "Updates a Fact" do
		fact_1 = post_fact({
			'fact' => "Cephalopods communicate by changing colors",
			'user_id' => user.id,
			'likes' => 0
		})

		patch "/api/v1/facts/#{fact_1['id']}", :params => { :fact => {:likes => 2} }, as: :json
		expect(response.status).to eq(200)

		parsed = JSON.parse(response.body)
		expect(parsed).to include('likes' => 2)
	end

	it "Destroys a Fact" do
		fact_1 = post_fact({
			'fact' => "Cephalopods communicate by changing colors",
			'user_id' => user.id,
			'likes' => 0
		})

		fact_2 = post_fact({
			'fact' => "Octopuses have three hearts",
			'user_id' => user.id,
			'likes' => 3
		})

		delete "/api/v1/facts/#{fact_1['id']}"
		expect(response.status).to eq(204)

		get "/api/v1/facts"
		expect(response.status).to eq(200)

		parsed = JSON.parse(response.body)
		expect(parsed).to contain_exactly(fact_2)
	end
end
