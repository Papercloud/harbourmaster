class <%= ("#{api_base_route}/#{plural_name}".split('/') - ['app', 'controllers']).map(&:camelize).join("::") -%>Controller < BaseApiController
  <% if options['authentication'] -%>
<%= "before_action :authenticate_user!" if options['authentication'] == 'devise' -%>
<%= "acts_as_token_authentication_handler_for User" if options['authentication'] == 'token' -%>
  <% end -%>

  <%= "actions :#{options['actions'].join(', :') }" if options['actions'].present? -%>

<% if options['permit_params'] -%>

  private

  def <%= name.underscore -%>_params
    params.require(:<%= name.underscore -%>).permit(:<%= (class_name.constantize.new.attribute_names - ["created_at", "updated_at"]).join(', :') %>)
  end
<% end -%>
end
