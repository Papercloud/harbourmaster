require "rails_helper"
require "rspec_api_documentation/dsl"

resource "User" do
  before do
    @user = create(:user)
  end

  # get INDEX docs
  get "/users" do
    parameter :name, "Name of the last record on the previous page", required: false, scope: :from

    example "Listing users" do
      do_request

      expect(status).to eq 200
    end

    let(:name) { "b" }
    example "Listing users from the letter B (pagination)" do
      explanation "This uses the paginative gem for pagination by showing only the records after the record you pass in."

      expect(params).to eq({ from: { name: "b" } }.as_json)
    end
  end

  # get SHOW docs
  get "/users/:id" do
    let(:id) { @user.id }

    example "Get a specific user" do
      do_request

      expect(status).to eq 200
    end
  end

  # post CREATE docs
  post "/users" do
    example "Creating a user" do
      do_request(@user.attributes.except("id", "created_at").as_json)

      expect(status).to eq 201
    end

    example "Creating a user - errors" do
      do_request

      expect(status).to eq 422
    end
  end

  put "/users/:id" do
    let(:id) { @user.id }

    example "Updating a specific user" do
      do_request

      expect(status).to eq 200
    end
  end

  delete "/users/:id" do
    let(:id) { @user.id }

    example "Deleting a specific user" do
      do_request

      expect(status).to eq 204
    end
  end
end
