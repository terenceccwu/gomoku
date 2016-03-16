class Gomoku
	def initialize
		@board = Board.new
		@turn = nil
	end

	def startGame
		choosePlayerType

		while !(winner = whoWins) #no one wins
		end

		if winner == -1
			puts "Draw game!"
		else
			puts "Player " + winner.symbol + " wins!"
		end
	end

	def choosePlayerType
		player_type = [nil,Computer, Human]

		printf("First player is (1) Computer or (2) Human? ")
		input = gets.to_i
		@player1 = player_type[input].new('O')

		puts "Player O is " + @player1.class.name

		printf("Second player is (1) Computer or (2) Human? ")
		input = gets.to_i
		@player2 = player_type[input].new('X')
		puts "Player X is " + @player2.class.name
	end

	def whoWins
		@turn = [@player1, @player2]
		for i in @turn
			#get nextMove
			cell = i.nextMove(@board)
			@board.set(cell,i.symbol)
			printf("Player %c places to row %d, col %d\n", i.symbol, cell[0], cell[1])
			
			printBoard
			if @board.checkWin(cell, i.symbol)
				return i
			end

			if @board.no_more_moves
				return -1
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
		# @board.set([3,3], 'X')
		# @board.set([2,2], 'X')
		# @board.set([1,1], 'X')
		# @board.set([4,4], 'X')
		# @board.set([5,5], 'X')
		@empty_cell = Array.new()
		for i in 0...@length
			for j in 0...@length
				@empty_cell.push([i,j]) if @board[i][j] == '.'
			end
		end
	end

	attr_reader :length

	def valueAt(cell)
		return @board[cell[0]][cell[1]]
	end

	def set(cell, symbol)
		@board[cell[0]][cell[1]] = symbol
		@empty_cell.delete(cell)
	end

	def no_more_moves
		return @empty_cell.length == 0
	end

	def get_empty_cell
		return @empty_cell
	end

	def is_occupied(cell)
		if @board[cell[0]][cell[1]] != '.'
			return true
		else
			return false
		end
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
			if(x-k < 0 || y+k > @board.length-1 || @board[x-k][y+k] != symbol)
				break
			else
				counter += 1
			end
		end
		# check left-down
		# x = cell[0]; y = cell[1]
		for k in 1..4
			if(x+k > @board.length-1 || y-k < 0 || @board[x+k][y-k] != symbol)
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
			if(x-k < 0 || y-k < 0 || @board[x-k][y-k] != symbol)
				break
			else
				counter += 1
			end
		end
		# check right-down
		# x = cell[0]; y = cell[1]
		for k in 1..4
			if( x+k > @board.length-1 ||  y+k > @board.length-1 || @board[x+k][y+k] != symbol)
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
	def nextMove(board)
		raise NotImplementedError
	end

	attr_reader :symbol
end

class Human < Player
	def nextMove(board)
		while 1
			printf("Player %c, make a move (row col): ", @symbol)
			input = gets.split.map { |e| e.to_i }
			if (input.all? {|e| e.between?(0,14)}) && !board.is_occupied(input)
				break
			else
				puts "Invalid input. Try again!"
			end
		end
		return input
	end
end

class Computer < Player
	def nextMove(board)
		possible_move = Array.new()
		empty_cell = Array.new()
		for cell in board.get_empty_cell
			if board.checkWin(cell , @symbol)
				possible_move.push(cell)
			end
		end
		puts 'done'

		if possible_move.length > 0
			return possible_move.sample # random sample an array element
		end

		if empty_cell.length > 0
			return empty_cell.sample
		end

		return nil

	end
end

Gomoku.new.startGame

a = Human.new('X')

