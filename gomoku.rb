class Gomoku
	def initialize
		@board = Array.new(15){Array.new(15){'.'}}
		@board[0][0] = 'X'
		@board[1][1] = 'X'
		@board[2][2] = 'X'
		@board[4][4] = 'X'
		@board[5][5] = 'X'

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
			printf("Player %c places to row %d, col %d\n", i.symbol, cell[0], cell[1])
			
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

				if counter >= 5
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

				if counter >= 5 # 4 more excluding itself
					return i
				end
			end

			#check diagonal
			counter = 0
			x = cell[0]; y = cell[1]
			# check right-up
			for k in 1...4
				if(@board[x-k][y+k] == i.symbol)
					counter += 1
				else
					break
				end
			end
			# check left-down
			x = cell[0]; y = cell[1]
			for k in 1...4
				if(@board[x+k][y-k] == i.symbol)
					counter += 1
				else
					break
				end
			end

			if counter >= 4
				return i
			end

			#check anti-diagonal
			counter = 0
			x = cell[0]; y = cell[1]
			# check left-up
			for k in 1...4
				if(@board[x-k][y-k] == i.symbol)
					counter += 1
				else
					break
				end
			end
			# check right-down
			x = cell[0]; y = cell[1]
			for k in 1...4
				if(@board[x+k][y+k] == i.symbol)
					counter += 1
				else
					break
				end
			end

			if counter >= 4
				return i
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

	def getBoard(x,y)
		return @board[x][y]
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

