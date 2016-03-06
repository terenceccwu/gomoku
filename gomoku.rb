class Gomoku
	def initialize
		@board = Array.new(15){Array.new(15){'.'}}
		@turn = 0
	end

	def startGame
		choosePlayerType

		while !(winner = wins) #no one wins
		end

		puts "Player " + winner.symbol + " wins!"
	end

	def choosePlayerType
		printf("First player is (1) Computer or (2) Human? ")
		input = gets
		@player1 = Human.new('O')

		puts "Player O is " + @player1.class.name

		printf("Second player is (1) Computer or (2) Human? ")
		input = gets
		@player2 = Human.new('X')
		puts "Player X is " + @player2.class.name
	end

	def wins
		@players = [@player1, @player2]
		for i in @players

			#get nextMove
			while !(cell = i.nextMove) || (@board[cell[0]][cell[1]] != '.')
				#if invalid range or occupied cell, error
				puts "Invalid input. Try again!"
			end
			@board[cell[0]][cell[1]] = i.symbol
			
			printBoard

			#determine if player wins:
			#check row
			counter = 0
			for y in 0...@board.length
				if @board[cell[0]][y] == i.symbol
						counter += 1
				else
					counter = 0
					next
				end

				if counter == 5
					return i
				end
			end

			#check column
			counter = 0
			for x in 0...@board.length
				if @board[x][cell[1]] == i.symbol
						counter += 1
				else
					counter = 0
					next
				end

				if counter == 5
					return i
				end
			end

			#check diagonal
			if cell[0] >= cell[1]
				x = cell[0] - cell[1]
				y = 0
			else
				x = 0
				y = cell[1] - cell[0]
			end

			counter = 0
			while x < @board.length	&& y < @board.length
				if @board[x][y] == i.symbol
					counter += 1
					x += 1; y += 1
				else
					counter = 0
					x += 1; y += 1
					next
				end

				if counter == 5
					return i
				end
			end

			#check anti-diagonal
			if cell[0] + cell[1] >= 14
				x = 14
				y = cell[0] + cell[1] - 14
			else
				x = cell[0] + cell[1]
				y = 0
			end

			counter = 0
			while x > 0	&& y < @board.length
				if @board[x][y] == i.symbol
					counter += 1
					x -= 1; y += 1
				else
					counter = 0
					x -= 1; y += 1
					next
				end

				if counter == 5
					return i
				end
			end
		end
		return nil #no one wins
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

