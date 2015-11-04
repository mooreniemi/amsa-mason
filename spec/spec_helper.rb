require 'pry'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('support', __FILE__)

Dir[File.dirname(__FILE__) + '/support/*.rb'].each {|file| require file }

require 'amsa-mason'
