require 'active_model_serializers'
module AmsaMason
  class IssueSerializer < ::ActiveModel::Serializer
    attributes :id, :title, :description, :severity
    has_many :attachments
  end
end
