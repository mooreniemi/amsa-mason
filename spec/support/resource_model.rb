
require 'active_model_serializers'
module AmsaMason
  class ResourceModel
    include ::ActiveModel::Model
    attr_accessor :id, :title, :description, :severity,
      :attachments, :controls
  end
end
