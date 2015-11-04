require "amsa-mason/version"
require "active_model_serializers"
require "socket"

module AmsaMason
  class Adapter < ::ActiveModel::Serializer::Adapter::Base
    def serializable_hash(*)
      serializer.
        attributes.
        merge!(relations).
        merge!(additional_properties).
        to_json
    end

    private
    def relations
      serializer.associations.inject({}) do |relation_hash, association|
        relation_hash.merge!(
          {
            association.name.to_sym => objects_of(association)
          }
        )
      end
    end
    def additional_properties
      {
        "@controls" => controls
      }
    end
    def controls
      {
        self: {
          href: "#{hostname}/#{resource_name_of(serializer.object)}/#{serializer.object.id}"
        },
        up: {
          href: "#{hostname}/#{parent_name}/#{serializer.object.parent.id}",
          title: serializer.object.parent.title
        }
      }.merge!(templates)
    end
    def templates
      serializer.templates.inject({}) do |templated, template_params|
        templated.merge!(template(template_params))
      end
    end
    def template(template_params)
      {
        "is:#{template_params[:name]}-#{resource_name_of(serializer.object).singularize}" => template_params.except(:name).merge!(
          {
            href: get_url_for(template_params[:name])
          }
        )
      }
    end
    def objects_of(association)
      serializer.object.send(association.name.to_sym).inject([]) do |array_of_objects, associated_object|
        array_of_objects << (
          # add controls to each associated object
          serializer_of(associated_object).new(associated_object).attributes.merge!(
            {
              "@controls" => {
                self:
                {
                  href: "#{hostname}/#{resource_name_of(associated_object)}/#{associated_object.id}"
                }
              }
            }
          )
        )
      end
    end
    def hostname
      Socket.gethostname
    end
    def resource_name_of(object)
      object.class.name.demodulize.tableize
    end
    def parent_name
      resource_name_of(serializer.object.parent)
    end
    def serializer_of(associated_object)
      (associated_object.class.to_s + "Serializer").constantize
    end
    def get_url_for(action)
      maybe_id = action != 'add' ? "/#{serializer.object.id}" : ""
      "#{hostname}/#{resource_name_of(serializer.object)}" + maybe_id
    end
  end
end
