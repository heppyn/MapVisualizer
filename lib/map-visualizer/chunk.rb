# frozen_string_literal: true

require_relative './block_info'

# Represents chunk of a scene
class Chunk
  attr_reader :position, :size

  def initialize(pos, size = 16)
    @position = pos
    @size = size
    @block_infos = Array.new(@size * @size, nil)
  end

  def [](index)
    check_bounds(index)

    @block_infos[index]
  end

  def []=(index, block_info)
    check_bounds(index)

    @block_infos[index] = block_info
  end

  def check_bounds(index)
    raise IndexError, "Index #{index} out ouf bounds [0, #{@size * @size})" if index.negative? || index >= @size * @size
  end
end
