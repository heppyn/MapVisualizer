# frozen_string_literal: true

require_relative '../lib/map-visualizer/loader'
require_relative '../lib/map-visualizer/visualizer'

# test Visualizer class
describe Visualizer do
  describe 'when running visualizer' do
    it 'generates map with trees' do
      scene = Loader.parse_scene('spec/test_data/scene1.json')
      vis = Visualizer.new(scene)
      vis.trees('trees.png')
    end
  end
end
