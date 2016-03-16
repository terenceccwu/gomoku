class Gomoku
	def initialize
		@board = Board.new
		# @board[0][0] = 'X'
		# @board[1][1] = 'X'
		# @board[2][2] = 'X'
		# @board[4][4] = 'X'
		# @board[5][5] = 'X'

		@turn = nil
	end

	def startGame
		choosePlayerType

		while !(winner = whoWins) #no one wins
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

	def whoWins
		@turn = [@player1, @player2]
		for i in @turn
			#get nextMove
			while !(cell = i.nextMove) || (@board.valueAt(cell) != '.')
				#if invalid range or occupied cell, error
				puts "Invalid input. Try again!"
			end
			@board.set(cell,i.symbol)
			printf("Player %c places to row %d, col %d\n", i.symbol, cell[0], cell[1])
			
			printBoard
			if @board.checkWin(cell, i.symbol)
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
				printf("%2c", @board.valueAt([i,j]))
			end
			puts nil
		end
	end

end

class Board
	def initialize
		@board = Array.new(15){Array.new(15){'.'}}
		@length = @board.length
	end

	attr_reader :length

	def valueAt(cell)
		return @board[cell[0]][cell[1]]
	end

	def set(cell, symbol)
		@board[cell[0]][cell[1]] = symbol
	end

	def checkWin(cell,symbol)
		x = cell[0]
		y = cell[1]
		# check column
		xmin = [x-4,0].max
		xmax = [x+4,@board.length-1].min
		counter = 0
		for i in xmin..xmax
			if @board[i][y] == symbol
					counter += 1
					if counter >= 5 # 4 more excluding itself
						return true
					end
			else
				counter = 0 # reset when disconected
			end
		end

		# check row
		ymin = [y-4,0].max
		ymax = [y+4,@board.length-1].min
		counter = 0
		for i in ymin..ymax
			if @board[x][i] == symbol
					counter += 1
					if counter >= 5 # 4 more excluding itself
						return true
					end
			else
				counter = 0 # reset when disconected
			end
		end

		#check /
		counter = 0
		# check right-up
		for k in 1..4
			if(@board[x-k][y+k] != symbol || x-k < 0 || y+k > @board.length-1)
				break
			else
				counter += 1
			end
		end
		# check left-down
		x = cell[0]; y = cell[1]
		for k in 1..4
			if(@board[x+k][y-k] != symbol || x+k > @board.length-1 || y-k < 0)
				break
			else
				counter += 1
			end
		end

		if counter >= 4
			return true
		end

		#check \
		counter = 0
		# check left-up
		for k in 1..4
			if(@board[x-k][y-k] != symbol || x-k < 0 || y-k < 0)
				break
			else
				counter += 1
			end
		end
		# check right-down
		x = cell[0]; y = cell[1]
		for k in 1..4
			if(@board[x+k][y+k] != symbol || x+k > @board.length-1 ||  y+k > @board.length-1)
				break
			else
				counter += 1
			end
		end

		if counter >= 4
			return true
		end
		return false
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
	def nextMove

	end
end

Gomoku.new.startGame

a = Human.new('X')

