# frozen_string_literal: true
require "numbered_list/list_item"

class NumberedList
  def self.render(items)
    new(items).render
  end

  attr_accessor :list_items

  def initialize(items)
    last_prefix = [0]
    last_heading_level = nil
    self.list_items = items.collect do |item|
      current_level = item[:heading_level]
      if current_level.zero?
        # if we hit a root one, we need to increment the primary count
        prefix = [last_prefix.first + 1]
      else
        prefix = last_prefix

        if prefix.size == 1
          # no child yet, add one, but respect the level
          current_level.times { prefix << 1 }
        elsif current_level > last_heading_level
          # we go deeper, so we need to indent, respecting the level
          (current_level - last_heading_level).times { prefix << 1 }
        elsif last_heading_level == current_level
          # we stay on the same level. so we just increment based on the previous index
          prefix << prefix.pop + 1
        else
          # we outdent, then increment the count by 1
          (last_heading_level - current_level).times { prefix.pop }
          prefix << prefix.pop + 1
        end
      end

      last_prefix = prefix
      last_heading_level = item[:heading_level]

      ListItem.new(item[:title], item[:heading_level], prefix.dup)
    end
  end

  def render
    list_items.collect(&:render).join("\n").strip
  end

end
