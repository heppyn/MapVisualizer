# frozen_string_literal: true

require_relative './block_info'

# Represents chunk of a scene
class Chunk
  attr_reader :position, :size

  # create empty chunk
  #
  # @param [Array] x and y position on a map - bottom left corner
  # @param [int] width and height of a chunk
  def initialize(pos, size = 16)
    @position = pos
    @size = size
    @block_infos = Array.new(@size * @size, nil)
  end

  # return BlockInfo at position specified by index
  #
  # @param [int] position
  def [](index)
    check_bounds(index)

    @block_infos[index]
  end

  # access BlockInfo at position specified by index
  #
  # @param [int] position
  def []=(index, block_info)
    check_bounds(index)

    @block_infos[index] = block_info
  end

  def check_bounds(index)
    raise IndexError, "Index #{index} out ouf bounds [0, #{@size * @size})" if index.negative? || index >= @size * @size
  end
end
