defmodule TestStuff do
  def get_item_lines(some_items) do
    Enum.reduce(some_items, [], fn item, acc ->
      [acc] ++ ["#{item.name} #{item.sell_in} #{item.quality}"]
    end)
  end
end

defmodule GildedRoseManyItemsTest do
  use ExUnit.Case, async: true
  import TestStuff

  describe "update_quality/1 with many items" do
    test "returns the expected results for now" do
      items = [
        %Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20},
        %Item{name: "Aged Brie", sell_in: 2, quality: 0},
        %Item{name: "Elixir of the Mongoose", sell_in: 5, quality: 7},
        %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
        %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: -1, quality: 80},
        %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20},
        %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 49},
        %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 49}
        # This Conjured item does not work properly yet
        # %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6},
      ]

      number_of_items = Enum.count(items)
      report_lines = []

      # Day 1
      report_lines = report_lines ++ ["-- day 1 --"] ++ get_item_lines(items)

      # Day 2
      items = GildedRose.update_quality(items)

      report_lines = report_lines ++ ["-- day 2 --"] ++ get_item_lines(items)
      index = Enum.find_index(report_lines, fn item -> item == "-- day 2 --" end)
      day_2_items = Enum.slice(report_lines, index + 1, number_of_items) |> List.flatten()

      assert day_2_items == [
               "+5 Dexterity Vest 9 19",
               "Aged Brie 1 1",
               "Elixir of the Mongoose 4 6",
               "Sulfuras, Hand of Ragnaros 0 80",
               "Sulfuras, Hand of Ragnaros -1 80",
               "Backstage passes to a TAFKAL80ETC concert 14 21",
               "Backstage passes to a TAFKAL80ETC concert 9 50",
               "Backstage passes to a TAFKAL80ETC concert 4 50"
             ]

      # Day 3
      items = GildedRose.update_quality(items)

      report_lines = report_lines ++ ["-- day 3 --"] ++ get_item_lines(items)
      index = Enum.find_index(report_lines, fn item -> item == "-- day 3 --" end)
      day_3_items = Enum.slice(report_lines, index + 1, number_of_items) |> List.flatten()

      assert day_3_items == [
               "+5 Dexterity Vest 8 18",
               "Aged Brie 0 2",
               "Elixir of the Mongoose 3 5",
               "Sulfuras, Hand of Ragnaros 0 80",
               "Sulfuras, Hand of Ragnaros -1 80",
               "Backstage passes to a TAFKAL80ETC concert 13 22",
               "Backstage passes to a TAFKAL80ETC concert 8 50",
               "Backstage passes to a TAFKAL80ETC concert 3 50"
             ]
    end
  end
end
