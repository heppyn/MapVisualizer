# frozen_string_literal: true

require_relative '../lib/map-visualizer/loader'

# test Scene class
describe Scene do
  scene = Loader.parse_scene('spec/test_data/scene1.json')

  describe 'when scene is created' do
    it 'has the correct width' do
      expect(scene.width).to eq 4
    end
    it 'has the correct height' do
      expect(scene.height).to eq 2
    end
    it 'has the correct size' do
      expect(scene.size).to eq Vec.new(4, 2)
    end
  end
end
