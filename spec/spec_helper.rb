require 'pry'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('support', __FILE__)

require 'support/issue'
require 'support/issue_serializer'
require 'amsa-mason'
