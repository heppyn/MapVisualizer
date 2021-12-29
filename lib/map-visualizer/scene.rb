# frozen_string_literal: true

require_relative 'chunk'

# Stores chunks
class Scene
  attr_reader :width, :height, :size, :chunks

  def initialize(chunks)
    raise IndexError, 'Scene cannot be empty' if chunks.to_a.size.zero?

    @chunks = {}
    chunks.each do |chunk|
      @chunks[chunk.position] = chunk
    end
    calc_size
  end

  def calc_size
    bottom_left, top_right = @chunks.keys.minmax

    @chunk_size = @chunks.values[0].size

    top_right += Vec.new(@chunk_size, @chunk_size)

    @width = top_right.x - bottom_left.x
    @height = top_right.y - bottom_left.y
    @size = Vec.new(width, height)
  end

  # Iterates over all chunks
  def each(&block)
    return enum_for(:each_value) unless block_given?

    @chunks.each_value(&block)
  end

  # Return BlockInfo at position on the scene
  #
  # @param [int] x coord
  # @param [int] y coord
  # @return [BlockInfo] block at location
  def [](x, y)
    mod_x = Math.abs(x) % @chunk_size
    mod_y = Math.abs(y) % @chunk_size
    pos = Vec.new(x - mod_x, y - mod_y)

    @chunks[pos][mod_x, mod_y]
  end
end
