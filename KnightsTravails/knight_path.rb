require 'set'
require_relative '../TreeNode/lib/00_tree_node'

class KnightPathFinder
    
    def self.valid_moves(positions, cons_pos)
        result = []
        positions.each do |pos|
            x, y = pos
            if x >= 0 && y >= 0 && x < 8 && y < 8 \
                && !cons_pos.include?(pos)
                result << pos
            end
        end
        return result
    end

    def initialize(origin)
        @origin = PolyTreeNode.new(origin)
        @considered_positions = Set.new()
        @possible_moves = []
        [-1,1].each do |i|
            [-2,2].each do |j|
                @possible_moves << [i,j] << [j,i]
            end
        end     
    end

    def new_move_positions(node)
        result = []
        pos = node.value
        @possible_moves.each do |move|
            result << [pos[0] + move[0], pos[1] + move[1]]
        end
        result = KnightPathFinder.valid_moves(result, @considered_positions)
        @considered_positions += result
        return result.map { |pos| PolyTreeNode.new(pos,node) }
    end

    def build_move_tree
        queue = [@origin]
        while !queue.empty?
            curr_node = queue.shift
            children = new_move_positions(curr_node)
            curr_node.children = children
            queue += children
        end
        return @origin
    end

end