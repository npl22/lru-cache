require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    @map.bucket.get(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    if map[key]
      update_node!(node)
    else
      insert(key)
    end
  end

  def insert(key)
    @store.append(key)
    eject!
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list


    @store.remove(node.key)
    @store.append(node.key, node.val)
  end

  def eject!
    @store.remove(first.key)
  end
end
