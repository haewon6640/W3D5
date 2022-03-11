require 'set'
require_relative '../TreeNode/lib/00_tree_node'

class KnightPathFinder
    
    def self.valid_moves(pos)
        x,y = pos
        if x >= 0 && y >= 0 && x < 8 && y < 8 && !@considered_positions.include?(pos)
            return true
        end
        false
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

    def new_move_positions(pos)
        result = []
        @possible_moves.each do |move|
            #current move = pos+move
            #check if curr_move is valid
            #if valid we add it to considered positions and the result array
            #if not then do nothing
            KnightPathFinder.valid_moves()
        end
        result
    end

    def build_move_tree
        
    end

end

finder = KnightPathFinder.new([0,0])