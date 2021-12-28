# frozen_string_literal: true

# Contains meta information about block
class BlockInfo
  attr_accessor :tree, :humidity, :temperature, :biome, :height

  def initialize(tree, humidity, temperature, biome, height)
    @tree = tree
    @humidity = humidity
    @temperature = temperature
    @biome = biome
    @height = height
  end
end
