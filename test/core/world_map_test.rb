require "test_helper"
require "./game/core/world_map.rb"

class WorldMapTest < Test::Unit::TestCase

  def test_new
    map = WorldMap.new
    puts map.get_tile 0, 0, 300, 300
  end
  
end