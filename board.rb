module Board

    def init_board(x)
        @num = x
        @store = Array.new(x * x){" "}
    end
    #row * x + i
    def display
        (0...@num).each do |i|
           (0...@num).each do |j|
                print "| #{@store[i * @num + j]}  "
                print "|" if j == (@num - 1)
           end
           print "\n"
        end
    end

    def change_state(loc1, loc2, value)
        @store[loc1 - 1] = value
        @store[loc2 - 1] = value
    end

    def can_change_state?(loc1, loc2)
        if @store[loc1 - 1] == " " and @store[loc2 - 1] == " "
            return true
        end
        print "Choose Empty Board location"
        return false
    end

    def row_win?(val)
        row_win_value = true
        (0...@num).each do |i|
            row_win_value = true
            (0...@num).each do |j|
                if !(@store[i * @num + j] == val)
                    row_win_value = false
                end
            end
            if row_win_value
                return row_win_value
            end
         end
         row_win_value
    end

    def column_win?(val)
        col_win_value = true
        (0...@num).each do |row_num|
            col_win_value = true
            (0...@num).each do |j|
                if !(@store[j * @num + row_num] == val)
                    col_win_value = false
                end
            end
            if col_win_value
                return col_win_value
            end
        end
        col_win_value
    end

    def diagonal_win?(val)
        diagonal_win_valu = true
        (0...@num).each do |i|
            if !(@store[i * @num + i] == val)
                diagonal_win_valu = false
            end
        end
        if diagonal_win_valu
            return true
        end
        diagonal_win_valu = true

        ## Reverse Diagonal match
        (0...@num).each do |i|
            if !(@store[i * @num + (@num - (1 + i))] == val)
                diagonal_win_valu = false
            end
        end
        diagonal_win_valu
    end

    def win?(val)
        row_win?(val) || column_win?(val) || diagonal_win?(val)
    end
end