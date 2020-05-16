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

    def win?(val)
        (0...@num).each do |i|
            (0...@num).each do |j|
                if !(@store[i * @num + j] == val)

                end
            end
         end
    end

    def draw?

    end
end