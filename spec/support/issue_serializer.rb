require 'active_model_serializers'
module AmsaMason
  class IssueSerializer < ::ActiveModel::Serializer
    attributes :id, :title, :description, :severity
    has_many :attachments

    def templates
      [
        {
          name: "add-issue",
          type: "json",
          schemaUrl: "https://bib.schema.org/ComicIssue"
        },
        {
          name: "delete-issue",
          type: "void",
          method: "DELETE"
        }
      ]
    end
  end
end
