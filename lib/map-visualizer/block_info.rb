# frozen_string_literal: true

# Contains meta information about block
class BlockInfo
  attr_accessor :tree, :humidity, :temperature, :height

  def initialize(tree, humidity, temperature, height)
    @tree = tree
    @humidity = humidity
    @temperature = temperature
    @height = height
  end
end
