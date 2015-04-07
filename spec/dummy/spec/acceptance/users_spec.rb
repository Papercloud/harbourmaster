require "rails_helper"
require "rspec_api_documentation/dsl"

resource "User" do
  before do
    @user = create(:user)
  end

  # get INDEX docs
  get "/app/controllers/api/v1/users" do

    example "Listing users" do
      do_request

      expect(status).to eq 200
    end

    parameter :name, "Name of the last record on the previous page", required: false, scope: :from
    let(:name) { "b" }
    example "Listing users from the letter B (pagination)" do
      explanation "This uses the paginative gem for pagination by showing only the records after the record you pass in."

      expect(params).to eq({ from: { name: "b" } }.as_json)
    end
  end

  # get SHOW docs
  get "/app/controllers/api/v1/users/:id" do
    let(:id) { @user.id }

    example "Get a specific user" do
      do_request

      expect(status).to eq 200
    end
  end



end
