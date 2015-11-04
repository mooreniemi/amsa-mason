require 'active_model_serializers'
module AmsaMason
  class IssueSerializer < ::ActiveModel::Serializer
    attributes :id, :title, :description, :severity
    has_many :attachments

    def templates
      [
        {
          # action-resource
          name: "add",
          # type is the response body type
          type: "json",
          schemaUrl: "https://bib.schema.org/ComicIssue",
          method: "POST"
        },
        {
          name: "delete",
          type: "void",
          method: "DELETE"
        }
      ]
    end
  end
end
