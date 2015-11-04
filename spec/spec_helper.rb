require 'pry'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('support', __FILE__)

require 'support/resource_serializer'
require 'support/resource_model'
require 'amsa-mason'
