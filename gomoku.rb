class Gomoku
	def initialize
		@board = Array.new(15){Array.new(15){'.'}}
		@turn = 0
	end

	def startGame
		printf("First player is (1) Computer or (2) Human? ")
		input = gets
		@player1 = Human.new('O')

		puts "Player O is " + @player1.class.name

		printf("Second player is (1) Computer or (2) Human? ")
		input = gets
		@player2 = Human.new('X')
		puts "Player X is " + @player2.class.name

		@players = [@player1, @player2]
		for i in @players

			#get nextMove
			while !(place = i.nextMove) || (@board[place[0]][place[1]] != '.')
				#if invalid range or occupied cell, error
				puts "Invalid input. Try again!"
			end
			@board[place[0]][place[1]] = i.symbol
			
			printBoard

			#determine if player wins:
		end

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

	attr_reader :symbol
end

class Human < Player
	def nextMove
		printf("Player %c, make a move (row col): ", @symbol)
		input = gets.split.map { |e| e.to_i }
		if !(input.all? {|e| e.between?(0,14)})
			return false
		end

		return input
	end
end

class Computer < Player
end

Gomoku.new.startGame

a = Human.new('X')

