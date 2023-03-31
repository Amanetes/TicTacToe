# frozen_string_literal: true

class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2], # Top row
    [3, 4, 5], # Middle row
    [6, 7, 8], # Bottom row
    [0, 3, 6], # First column
    [1, 4, 7], # Second column
    [2, 5, 8], # Third column
    [0, 4, 8], # First diagonal
    [6, 4, 2] # Second diagonal
  ].freeze

  def initialize
    @board = Array.new(9, ' ')
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '-----------'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '-----------'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, token = 'X')
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != ' '
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn_count
    @board.count { |token| token != ' ' }
  end

  def current_player
    turn_count.even? ? 'X' : 'O'
  end

  def turn
    puts 'Please enter position from 1 to 9:'
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      puts 'Invalid move!'
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
      return combination if combination.all? { |index| @board[index] == 'X' }
      return combination if combination.all? { |index| @board[index] == 'O' }
    end
    false
  end

  def full?
    @board.all? { |token| token != ' ' }
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    return @board[won?[0]] if won?

    nil
  end

  def play
    turn until over?
    puts "Congratulations #{winner}!" if won?
    puts "Cat's Game!" if draw? # "Cat's Game! - ничья в игре крестики-нолики"
  end
end
