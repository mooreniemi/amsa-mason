require 'active_model_serializers'
module AmsaMason
  class ProjectSerializer < ::ActiveModel::Serializer
    attributes :id, :title
    has_many :issues

    def actions
      [
        {
          # action-resource
          name: "update",
          # type is the response body type
          type: "json",
          title: "Update project details",
          schemaUrl: "https://bib.schema.org/ComicIssue",
          method: "PUT",
          template: {
            code: "SHOP",
            title: "Webshop",
            description: "All issues related to the webshop.",
            authToken: "jh987yfm16"
          }
        }
      ]
    end
  end
end
