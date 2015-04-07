class <%= ("#{api_base_route}/#{plural_name}Controller".split('/') - ['app', 'controllers']).map(&:camelize).join("::") %> < BaseApiController
  <%= "actions :#{options['actions'].join(', :') }" if options['actions'].present? -%>

<% if options['permit_params'] -%>

  private

  def permitted_params
    params.require(:<%= name.underscore -%>).permit(:<%= (class_name.constantize.new.attribute_names - ["created_at", "updated_at"]).join(', :') %>)
  end
<% end -%>
end
