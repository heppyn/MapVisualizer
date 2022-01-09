# frozen_string_literal: true

require_relative '../lib/map-visualizer/loader'
require_relative '../lib/map-visualizer/visualizer'

# test Visualizer class
describe Visualizer do
  describe 'when running visualizer' do
    scene = Loader.parse_scene('spec/test_data/export.json')
    visualizer = Visualizer.new(scene)

    it 'generates map with trees' do
      visualizer.trees('./maps/trees.png')
    end
    it 'generates map with biomes' do
      visualizer.biomes('./maps/biomes.png')
    end
    it 'generates map with humidity' do
      visualizer.humidity('./maps/humidity.png')
    end
    it 'generates map with temperature' do
      visualizer.temperature('./maps/temperature.png')
    end
    it 'generates map with height' do
      visualizer.height('./maps/height.png')
    end
  end
end
