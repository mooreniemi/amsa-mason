require 'active_model_serializers'
module AmsaMason
  class ResourceSerializer < ::ActiveModel::Serializer
    attributes :title, :description, :severity,
      :attachments, :controls
  end
end
