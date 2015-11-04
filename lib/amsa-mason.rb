require "amsa-mason/version"
require "active_model_serializers"
require 'socket'

module AmsaMason
  # First thing, your adapter should inherit from ActiveModel::Serializer::Adapter::Base. Then you mainly have to define one method: serializable_hash (and possibly fragment_cache in case you want to support fragment caching, but let's get into this later).
  class Adapter < ::ActiveModel::Serializer::Adapter::Base
    def serializable_hash(*)
      # as you can see here: https://github.com/rails-api/active_model_serializers/blob/master/lib/active_model/serializer/adapter/base.rb#L12
      # your adapter instance will be provided with an instance of a serializer (for the root object/collection), and some options (`instance_options`)
      # + serializer.object will be the root object/collection,
      # + serializer.attributes will be the list of key/value for the attributes you are supposed to serialize
      # + serializer.associations will be the list of associations (key is the name, value is a serializer instance for the related resource)
      # your adapter's role will be to turn all that into a hash that represents the JSON document you want to output
      serializer.
        attributes.
        merge!(additional_properties).
        merge!(relations).
        to_json
    end

    private
    def additional_properties
      {
        "@controls" => controls
      }
    end
    def relations
      serializer.associations.inject({}) do |relation_hash, association|
        relation_hash.merge!(
          {
            association.name.to_sym => objects_of(association)
          }
        )
      end
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
      }
    end
    def objects_of(association)
      serializer.object.send(association.name.to_sym).inject([]) do |array_of_objects, associated_object|
        associated_serializer = (associated_object.class.to_s + "Serializer").constantize
        array_of_objects << (
          associated_serializer.new(associated_object).attributes.merge!(
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
  end
end
