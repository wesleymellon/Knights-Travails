class Knight
  def initialize(start, finish)
    @start = start
    @finish = finish
    @queue = [Node.new(start, nil)]
    @complete = false
    @answer_node = nil
  end

  def create_children(node)
    possible_positions = []
    node_horz = node.value[0]
    node_vert = node.value[1]
    possible_positions << [node_horz - 1, node_vert - 2]
    possible_positions << [node_horz - 1, node_vert + 2]
    possible_positions << [node_horz - 2, node_vert - 1]
    possible_positions << [node_horz - 2, node_vert + 1]
    possible_positions << [node_horz + 1, node_vert - 2]
    possible_positions << [node_horz + 1, node_vert + 2]
    possible_positions << [node_horz + 2, node_vert - 1]
    possible_positions << [node_horz + 2, node_vert + 1]

    possible_positions.select! do |x|
      x[0] >= 0 && x[1] >= 0
    end

    possible_positions.each do |x|
      @queue << Node.new(x, node)
    end
  end

  def find_length(node)
    counter = 0
    while node != nil
      node = node.parent
      counter += 1
    end
    counter
  end

  def find_lineage(node)
    path = []
    while node != nil
      path << node.value
      node = node.parent
    end
    path.reverse
  end

  def move_knight
    node = @queue.shift
    if node.value == @finish
      @complete = true
      @answer_node = node
    else
      create_children(node)
    end 
  end

  def knight_moves
    until @complete
      move_knight
    end
    path = find_lineage(@answer_node)
    length = find_length(@answer_node)
    p "You made it in #{length} moves! Here's your path:"
    p path
  end
end

class Node

  attr_accessor :parent, :value
  def initialize(value, parent)
    @parent = parent
    @value = value
  end
end
