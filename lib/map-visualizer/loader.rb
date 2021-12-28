# frozen_string_literal: true

require 'json'
require_relative './chunk'

# Loads scene from JSON
class Loader
  # Load and return scene from file in JSON format
  #
  # @param [String] path to the file
  def self.parse_scene(scene_path)
    scene_data = JSON.load_file(scene_path, { symbolize_names: true })
    scene = []

    scene_data[:chunks].each do |chunk_data|
      scene.push(parse_chunk(chunk_data))
    end

    scene
  end

  # return Chunk from hash
  #
  # @param [Hash] data with symbols as keys
  def self.parse_chunk(chunk_data)
    size = Math.sqrt(chunk_data[:meta].size)
    pos = [chunk_data[:pos][0].to_i, chunk_data[:pos][1].to_i]
    chunk = Chunk.new(pos, size)

    index = 0
    chunk_data[:meta].each do |info|
      chunk[index] = parse_info(info)
      index += 1
    end

    chunk
  end

  # return BlockInfo from hash
  #
  # @param [Hash] data with symbols as keys
  def self.parse_info(info)
    BlockInfo.new(
      info[:tree].to_i != 0,
      info[:hum].to_i,
      info[:tem].to_i,
      info[:biome].to_i,
      info[:height].to_i
    )
  end
end
