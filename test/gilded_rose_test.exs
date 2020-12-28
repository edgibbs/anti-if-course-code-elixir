defmodule GildedRoseTest do
  use ExUnit.Case, async: true

  describe "update_quality/1 with a backstage pass" do
    test "returns sell_in and quality minus one" do
      updated_items = GildedRose.update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
      updated_item = List.first(updated_items)

      assert updated_item.sell_in == 8
      assert updated_item.quality == 3
    end
  end
end
