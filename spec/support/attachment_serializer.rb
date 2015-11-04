require 'active_model_serializers'
module AmsaMason
  class AttachmentSerializer < ::ActiveModel::Serializer
    attributes :id, :title
  end
end
