# Harbourmaster

**The smarter way to generate and manage controllers, serializers, and docs**

Building a JSON API can be pretty straightforward, but it can also take a lot of time. 

Write. Test. Serialize. Document. Bugfix. Document. Repeat.

Harbourmaster aims to speed up this process by allowing you to generate as many of these things in on the fly, and update them as you need.

## Installation

Add `harbourmaster` to both the `:development` and `:test` groups in the `Gemfile`:

```ruby
group :development, :test do
  gem 'harbourmaster'
end
```

Install by running: 

```
bundle install
```

Initialize your harbourmaster by running:

```
rails generate harbourmaster:install
```

This will add the following to your rails project:

**Serializers and documentation initializers**

* `config/initializers/active_model_serializer.rb`
* `config/initializers/rspec_api_documentation.rb`
* `config/initializers/apitome.rb`

**A base controller for your API**

* `app/controllers/base_api_controller.rb`

## What you get out of the box 

Harbourmaster was built to make it easy to generate a documented JSON API rails aplication. It builds off the excellent [Active Model Serializers](https://github.com/rails-api/active_model_serializers), [Rspec Api Documentation](https://github.com/zipmark/rspec_api_documentation), [Inherited Resources](https://github.com/josevalim/inherited_resources) and [Ransack](https://github.com/activerecord-hackery/ransack) gems. As well as our own [Ragamuffins](https://github.com/Papercloud/ragamuffins) and [Paginative](https://github.com/Papercloud/paginative) to get you up and running in no time.

When you run the install you get the initializers for all of the above, as well as a `base_api_controller.rb` which handles the ransack and pagination of your API. These are imported into your project so that you can customise them as you need, or leave them as their defaults.

## Controllers

Making and documenting controllers is a pain, but your Harbourmaster is here to help. 

```
rails generate harbourmaster:controller NAME [API_BASE_ROUTE] [options]
```

This generates:

* a controller which inherits from your `BaseApiController`,
* a set of acceptance tests used to generate documentation,
* a serializer for the model you are writing the controller for.

The `[API BASE ROUTE]` defaults to `"app/controllers/api"`. This is the folder where your controller will be generated

**Other options**

`-a` allows you to pass in actions that you want generated in the controller, as an example `-a index show` will generate a controller with the `index` and `show` actions already made

`--permit_params` will generate a hash of permitted params in the controller

`--skip_tests` will skip the generation of the acceptance tests used for generating the documentation

### Example

Given a basic example of a `User` model with a `:name` and `:email`

`rails generate harbourmaster:controller User "app/api/v1" --permit-params -a index show update`

would output the following controller at `app/api/v1/users_controller.rb`:


```ruby
class UsersController < BaseApiController
  actions :index, :show, :update

  private

  def permitted_params
    params.require(:user).permit(:id, :name, :email)
  end
end
```

it would also output the following `user_serializer`:

```ruby
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at, :updated_at
end
```

and a set of acceptance specs at `spec/acceptance/users_spec.rb`:

*(this is just a snippet)*

```ruby
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
```

From here you can edit your controllers, specs or serializer as you please.

## Contributing

Think there is something more that you would like your harbourmaster to do for you?

**Fork it** 

**Test it**

**Commit it**

**PR it**

I will try my hardest to keep on top of issues and merge pull requests in a timely manner.

## License

This project rocks the MIT license.
