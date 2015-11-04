require "amsa-mason/version"
require "active_model_serializers"

module AmsaMason
  # First thing, your adapter should inherit from ActiveModel::Serializer::Adapter::Base. Then you mainly have to define one method: serializable_hash (and possibly fragment_cache in case you want to support fragment caching, but let's get into this later).
  class Adapter < ::ActiveModel::Serializer::Adapter::Base
    def serializable_hash
      # as you can see here: https://github.com/rails-api/active_model_serializers/blob/master/lib/active_model/serializer/adapter/base.rb#L12
      # your adapter instance will be provided with an instance of a serializer (for the root object/collection), and some options (`instance_options`)
      # + serializer.object will be the root object/collection,
      # + serializer.attributes will be the list of key/value for the attributes you are supposed to serialize
      # + serializer.associations will be the list of associations (key is the name, value is a serializer instance for the related resource)
      # your adapter's role will be to turn all that into a hash that represents the JSON document you want to output
      # Dummy example:
      serializer.object.to_h # in case your root object supports the `to_h` method.
    end
  end
end
