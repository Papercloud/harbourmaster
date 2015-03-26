class <%= class_name -%>Serializer < ActiveModel::Serializer
  attributes :<%= (class_name.constantize.new.attribute_names).join(', :') %>
end
