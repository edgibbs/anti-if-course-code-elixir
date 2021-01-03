defmodule TestStuff do
  def get_item_lines(some_items) do
    Enum.reduce(some_items, [], fn item, acc ->
      # IO.puts("Items in the items line loop: #{inspect(some_items)}")
      [acc] ++ ["#{item.name} #{item.sell_in} #{item.quality}"]
    end)
  end
end

defmodule GildedRoseManyItemsTest do
  use ExUnit.Case, async: true
  import TestStuff

  describe "update_quality/1 with many items" do
    test "returns the expected results for now" do
      items =  [
          %Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20},
          %Item{name: "Aged Brie", sell_in: 2, quality: 0},
          # %Item{name: "Elixir of the Mongoose", sell_in: 5, quality: 7},
          # %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
          # %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: -1, quality: 80},
          # %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20},
          # %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 49},
          # %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 49},
          # This Conjured item does not work properly yet
          # %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6},
          ]

      report_lines = []

      # Day 0
      report_lines = report_lines ++ ["-- day 1 --"] ++ get_item_lines(items)
      IO.puts "report lines is #{inspect(report_lines)}"

      # Day 1
      items = GildedRose.update_quality(items)
      report_lines = report_lines ++ ["-- day 2 --"] ++ get_item_lines(items)
      IO.puts "report lines is #{inspect(report_lines)}"

      # Day 2
      items = GildedRose.update_quality(items)
      report_lines = report_lines ++ ["-- day 3 --"] ++ get_item_lines(items)
      IO.puts "report lines is #{inspect(report_lines)}"
    end
  end
end
