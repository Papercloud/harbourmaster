require "rails_helper"
require "rspec_api_documentation/dsl"

resource "<%= name.camelize %>" do
  before do
    @<%= name.underscore -%> = create(:<%= name.underscore -%>)
  end

  <%- if options["actions"].include? "index" -%>
  # get INDEX docs
  get "<%= api_base_route.gsub('app/controllers', '') -%>/<%= plural_name -%>" do

    example "Listing <%= plural_name -%>" do
      do_request

      expect(status).to eq 200
    end

    parameter :name, "Name of the last record on the previous page", required: false, scope: :from
    let(:name) { "b" }
    example "Listing <%= plural_name -%> from the letter B (pagination)" do
      explanation "This uses the paginative gem for pagination by showing only the records after the record you pass in."

      expect(params).to eq({ from: { name: "b" } }.as_json)
    end
  end
  <%- end -%>

  <%- if options["actions"].include? "show" -%>
  # get SHOW docs
  get "<%= api_base_route.gsub('app/controllers', '') -%>/<%= plural_name -%>/:id" do
    let(:id) { @<%= name.underscore -%>.id }

    example "Get a specific <%= name.underscore %>" do
      do_request

      expect(status).to eq 200
    end
  end
  <%- end -%>

  <%- if options["actions"].include? "create" -%>
  # post CREATE docs
  post "<%= api_base_route.gsub('app/controllers', '') -%>/<%= plural_name -%>" do
    example "Creating a <%= name.underscore %>" do
      do_request(<%= name.underscore %>: @<%= name.underscore -%>.attributes.except("id", "created_at").as_json)

      expect(status).to eq 201
    end
  end
  <%- end -%>

  <%- if options["actions"].include? "update" -%>
  put "<%= api_base_route.gsub('app/controllers', '') -%>/<%= plural_name -%>/:id" do
    let(:id) { @<%= name.underscore -%>.id }

    example "Updating a specific <%= name.underscore -%>" do
      do_request(<%= name.underscore %>: @<%= name.underscore -%>.attributes.except("created_at").as_json)

      expect(status).to eq 200
    end
  end
  <%- end -%>

  <%- if options["actions"].include? "destroy" -%>
  delete "<%= api_base_route.gsub('app/controllers', '') -%>/<%= plural_name %>/:id" do
    let(:id) { @<%= name.underscore %>.id }

    example "Deleting a specific <%= name.underscore %>" do
      do_request

      expect(status).to eq 204
    end
  end
  <%- end -%>
end
