class Gomoku
	def initialize
		@board = Array.new(15){Array.new(15){'.'}}
		@turn = 0
	end

	def startGame
		option = ['Computer', 'Human']

		printf("First player is (1) Computer or (2) Human? ")
		@player1 = gets
		puts "Player O is " + option[@player1.to_i-1]

		printf("Second player is (1) Computer or (2) Human? ")
		@player2 = gets
		puts "Player X is " + option[@player2.to_i-1]
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

Gomoku.new.startGame
