class Gomoku
	def initialize
		@board = Array.new(15){Array.new(15){'.'}}
		@player1 = nil
		@player2 = nil
		@turn = 0
	end

	def startGame
	end

	def printBoard
		puts "                       1 1 1 1 1"
		puts "   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4"
		for i in 0...@board.length
			printf("%2d", i)
			for j in 0...@board.length
				printf("%2c", @board[i][j])
			end
			puts nil
		end
	end
end

class Player
	def initialize(symbol)
		@symbol = symbol
	end
	def nextMove
		raise NotImplementedError
	end
end

class Human
end

class Computer
end

a = Gomoku.new
a.printBoard