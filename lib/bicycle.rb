require 'bicycle/version'

require 'bicycle/card'
require 'bicycle/deck'
require 'bicycle/hand'

module Bicycle
  InvalidCardError = Class.new(StandardError)
end
