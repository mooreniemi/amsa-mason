require 'active_model_serializers'
module AmsaMason
  class Issue
    include ::ActiveModel::Model
    include ::ActiveModel::Serialization
    attr_accessor :id, :title, :description, :severity,
      :attachments

    def parent
      AmsaMason::Project.new(id: 1, title: "Containing project")
    end
    def attachments
      [
        AmsaMason::Attachment.new(id: 1, title: "Error report")
      ]
    end
  end
end
