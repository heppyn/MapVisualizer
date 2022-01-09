# frozen_string_literal: true

require_relative './block_info'
require_relative './helpers/vec'

# Represents chunk of a scene
class Chunk
  attr_reader :position, :size

  # create empty chunk
  #
  # @param [Array | Vec] x and y position on a map - bottom left corner
  # @param [int] width and height of a chunk
  def initialize(pos, size = 16)
    add_pos(pos)
    @size = size
    @block_infos = Array.new(@size * @size, nil)
  end

  # return BlockInfo at position specified by index
  #
  # @param [int, [int, int]] position
  def [](*args)
    case args.count
    when 1
      check_bounds(args[0])
      @block_infos[args[0]]
    when 2
      self[args[1] * size + args[0]]
    else
      raise ArgumentError, "Wrong number of arguments #{args.count}"
    end
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

  # Iterates over all blocks
  def each(&block)
    return enum_for(:each) unless block_given?

    @block_infos.each(&block)
  end

  # Set position
  #
  # @param [Array, Vec] position
  def add_pos(pos)
    case pos
    when Vec
      @position = pos
    when Array
      @position = Vec.new(*pos)
    else
      raise ArgumentError, 'pos must be Vec or Array'
    end
  end
end
