require 'active_model_serializers'
module AmsaMason
  class Project
    include ::ActiveModel::Model
    include ::ActiveModel::Serialization
    attr_accessor :id, :title

    def issues
      []
    end

    def parent
      :root
    end
  end
end
