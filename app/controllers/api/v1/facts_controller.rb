class Api::V1::FactsController < ApplicationController
	before_action :set_fact, :only => [ :show, :update, :destroy ]

	# GET /facts
	def index
		@facts = Fact.all
		render json: @facts
	end

	# GET /facts/:id
	def show
		render json: @fact
	end

	# POST /facts
	def create
		@fact = Fact.new(fact_params)

		if @fact.save
			render json: @fact, status: :created, location: api_v1_facts_path(@fact)
		else
			render json: @fact.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /facts/:id
	def update
		if @fact
			@fact.update(fact_params)
			render json: @fact
		else
			render json: @fact.errors, status: :unprocessable_entity
		end
	end

	# DELETE /facts/:id
	def destroy
		@fact.destroy
	end

	private

	def set_fact
		@fact = Fact.find(params[:id])
	end

	def fact_params
		params.require(:fact).permit(:fact, :likes, :user_id)
	end
end
