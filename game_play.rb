require_relative './board'
class GamePlay
    include Board
    def initialize(x)
        init_board(4)
        @current_player = 1
        @player_values = ["X", "0"]
        @num_of_turn = 0
    end

    def valid_move(loc1, loc2)
        if loc1.between?(1, 16) and loc2.between?(1, 16)
            if loc1 == loc2
                puts "Can not enter same value\n"
            end
            return false if loc1 == loc2
            return can_change_state?(loc1, loc2)
        else
            puts "Enter value between 1-16, integer allowed"
            return false
        end
    end

    def get_formatted_value()
        puts "Choose number between (1-16)(Format: location1,location2) "
        puts "\n"
        print "Player #{@current_player}: \n"
        unformat_values = gets.strip
        vals = unformat_values.split(',').map(&:strip).map(&:to_i)
        return vals
    end

    def next_turn
        @num_of_turn = @num_of_turn + 1
        loop do
            values = get_formatted_value()
            loc1 = values[0]
            loc2 = values[1]
            valid_loc_or_val = false
            valid_loc_or_val = valid_move(loc1, loc2)
            if valid_loc_or_val
                change_state(loc1, loc2, @player_values[@current_player - 1])
            end
            break if valid_loc_or_val

        end
    end

    def complete?
        false
    end

    def run
        loop do
            display()
            next_turn()
            break if complete?

            if @current_player == 1
                @current_player = 2
            else
                @current_player = 1
            end
        end
    end
end

loop do
    game_play = GamePlay.new(4)
    game_play.run()
    print("Want to play game agin(Y/N)")
    answer = gets.chomp
    until ["Y", "N"].include?(answer) do
        print("Want to play game agin(Y/N)")
        answer = gets.chomp
    end
    break if answer == "N"
end