require 'set'
require_relative '../TreeNode/lib/00_tree_node'

class KnightPathFinder
    
    def self.valid_moves(positions, cons_pos)
        # Refactor this to filter out of considered positions in new_move_positions
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
        build_move_tree
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

    def find_path(end_pos)
        target = @origin.dfs(end_pos)
        return trace_path_back(target)
    end

    def trace_path_back(leaf) 
        result = []
        while leaf != nil
            result.unshift(leaf.value)
            leaf = leaf.parent
        end
        result
    end
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]