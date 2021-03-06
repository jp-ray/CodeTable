class Grid
    attr_accessor :grid
    attr_reader :min

    def initialize(grid, startX, startY, goalX, goalY)
        @grid = []
        grid.each do |el|
            @grid << el.split('')
        end
        @n = grid.length
        @stack = [[startX, startY, 0]]
        @gx = goalX
        @gy = goalY
        @min = 1000000000000
    end

    def mark_all_reachable(i, j, distance)
        t=  i + 1
        while(t < @n and @grid[t][j] != 'X')
            if push(t, j, distance+1)
                if @min > distance+1
                    @min = distance+1
                end
            end
            t += 1
        end        
        t = i - 1
        while(t >= 0 and @grid[t][j] != 'X')
            if push(t, j, distance+1)
                if @min > distance+1
                    @min = distance+1
                end
            end
            t -= 1
        end
        t = j + 1
        while(t < @n and @grid[i][t] != 'X')
            if push(i, t, distance+1)
                if @min > distance+1
                    @min = distance+1
                end
            end
            t += 1 
        end
        t = j - 1
        while(t >= 0 and @grid[i][t] != 'X')
            if push(i, t, distance+1)
                if @min > distance+1
                    @min = distance+1
                end
            end
            t -= 1
        end
        @grid[i][j] = 2
    end
    
    def push(i, j, distance)
        if(i == @gx and j == @gy)
            @grid[i][j] = 1
            return true
        end
        if(@grid[i][j] == '.')
            @stack.insert(0, [i, j, distance])
            @grid[i][j] = 1
        end
        return false
    end
    
    def solve
        while(popped_item = @stack.pop)
            mark_all_reachable(popped_item[0], popped_item[1], popped_item[2])
            @grid.each do |el|
                p el
            end
            puts;puts
        end
        return @min
    end
end

# Complete the minimumMoves function below.
def minimumMoves(grid, startX, startY, goalX, goalY)
    return 0 if([startX, startY] == [goalX, goalY])
    return Grid.new(grid, startX, startY, goalX, goalY).solve
end

#grid = ['.XXX', '.X.X', '.X..', '..X.']

grid = %q{.X..XX...X
X.........
.X.......X
..........
........X.
.X...XXX..
.....X..XX
.....X.X..
..........
.....X..XX}.split("\n")

grid.each do |el|
    p el
end
puts;puts
p minimumMoves(grid, 9, 1, 9, 6)
