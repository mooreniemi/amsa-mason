
require 'active_model_serializers'
module AmsaMason
  class Issue
    include ::ActiveModel::Model
    include ::ActiveModel::Serialization
    attr_accessor :id, :title, :description, :severity,
      :attachments
  end
end
