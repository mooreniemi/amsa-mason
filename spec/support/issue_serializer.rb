require 'active_model_serializers'
module AmsaMason
  class IssueSerializer < ::ActiveModel::Serializer
    attributes :title, :description, :severity,
      :attachments
  end
end
