require 'active_model_serializers'
module AmsaMason
  class Attachment
    include ::ActiveModel::Model
    include ::ActiveModel::Serialization
    attr_accessor :id, :title
  end
end
