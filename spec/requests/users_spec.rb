require 'rails_helper'

RSpec.describe "Users", type: :request do
	
	def post_user(user)
		headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
		post '/api/v1/users', :params => {:user => user}, as: :json

		expect(response.status).to eq(201)

		parsed = JSON.parse(response.body)
		expect(parsed).to include('id' => a_kind_of(Integer))
		user.merge('id' => parsed['id'], 'created_at' => parsed['created_at'], 'updated_at' => parsed['updated_at'])
	end
	
	it "Manages Users" do
		user_1 = post_user({
			'username' => "User1",
			'password' => "secret"
		})

		user_2 = post_user({
			'username' => "User2",
			'password' => "secret"
		})

		get '/api/v1/users'
		expect(response.status).to eq(200)

		users = JSON.parse(response.body)
		expect(users).to contain_exactly(user_1, user_2)
	end

	it "Gets a User" do
		user_1 = post_user({
			'username' => "User1",
			'password' => "secret"
		})

		get "/api/v1/users/#{user_1['id']}"
		expect(response.status).to eq(200)

		parsed = JSON.parse(response.body)
		expect(parsed).to eq(user_1)
	end

	it "Updates a User" do
		user_1 = post_user({
			'username' => "User1",
			'password' => "secret"
		})
		
		patch "/api/v1/users/#{user_1['id']}", :params => {:user => {:username => "changed"}}, as: :json
		expect(response.status).to eq(200)

		parsed = JSON.parse(response.body)
		expect(parsed).to include('username' => 'changed')
	end

	it "Destroys a User" do
		user_1 = post_user({
			'username' => "User1",
			'password' => "secret"
		})

		user_2 = post_user({
			'username' => "User2",
			'password' => "secret"
		})

		delete "/api/v1/users/#{user_1['id']}"
		expect(response.status).to eq(204)

		get "/api/v1/users"
		expect(response.status).to eq(200)

		parsed = JSON.parse(response.body)
		expect(parsed).to contain_exactly(user_2)
	end
end
