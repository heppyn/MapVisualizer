# frozen_string_literal: true

require 'color'
require 'chunky_png'

# Convert biome type to color
class Biome
  # https://github.com/heppyn/VoxelGame/blob/d44830ec2fe314ddc69e3e446a5d0d6393395aac/VoxelGame/src/game/Biome.h#L8
  # https://github.com/halostatue/color/blob/2159ca233851ca3304414b831d9da368dcbafb04/lib/color/rgb/colors.rb#L9
  @@biome_to_color = [
    Color::RGB::Snow.hex, # Ice
    Color::RGB::SandyBrown.hex, # Tundra
    Color::RGB::LawnGreen.hex, # Grassland
    Color::RGB::PowderBlue.hex, # ColdDesert
    Color::RGB::YellowGreen.hex, # Woodland
    Color::RGB::SaddleBrown.hex, # BorealForest
    Color::RGB::DarkKhaki.hex, # Shrubland
    Color::RGB::DarkRed.hex, # SeasonalForest
    Color::RGB::DarkCyan.hex, # TemperateRainforest
    Color::RGB::Yellow.hex, # SubtropicalDesert
    Color::RGB::DarkOliveGreen.hex, # TropicalForest
    Color::RGB::Orange.hex, # Savanna
    Color::RGB::ForestGreen.hex, # TropicalRainforest
    Color::RGB::DeepSkyBlue.hex # Water
  ].freeze

  def self.biome_color(biome)
    raise IndexError, "Color not defined for biome #{biome}" if biome >= @@biome_to_color.size

    ChunkyPNG::Color(@@biome_to_color[biome])
  end

  def self.water?(biome)
    biome == 13
  end
end
