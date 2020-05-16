require_relative './board'
class GamePlay
    include Board
    def initialize(x)
        init_board(4)
        @current_player = 1
        @player_values = ["X", "0"]
        @num_of_turn = 0
        @player_names = []
        @win = false
        @winner_player = ""
    end

    def valid_move(loc1, loc2)
        if (loc1 && loc1.between?(1, 16)) and (loc2 && loc2.between?(1, 16))
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
        current_value = @player_values[@current_player - 1]
        puts "Choose number between (1-16)(Format: location1,location2) "
        puts "\n"
        print "Player #{@player_names[@current_player-1]}(#{current_value}): \n"
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

    def draw?
        if @num_of_turn >= 8
            print "==================="
            print "....GAME DRAW......"
            print "==================="
            return true
        end
        return false
    end



    def complete?
        current_value = @player_values[@current_player - 1]
        @win = win?(current_value)
        return (draw? || @win)
    end

    def announce_winner
        print "=============================================================================\n\n"
        print " Congratulations Player: #{@player_names[@current_player - 1]} for your win \n\n"
        print "=============================================================================\n\n"
    end

    def run
        if @player_names.length == 0
            puts "** Enter First Player Name: "
            @player_names[0] = gets.strip
            puts "** Enter Second Player Name: "
            @player_names[1] = gets.strip
        end
        loop do
            display()
            next_turn()
            if complete?
                if @win
                    announce_winner
                end
                break
            end
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
    print "\n\n"
    print "========================="
    print("Want to play game agin(Y/N)")
    answer = gets.chomp
    until ["Y", "N"].include?(answer) do
        print("Want to play game agin(Y/N)")
        answer = gets.chomp
    end
    break if answer == "N"
    Gem.win_platform? ? (system "cls") : (system "clear")
end