class PersonSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :phone, :email
end
