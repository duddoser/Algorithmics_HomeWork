function length(robot)
    cells = 0
    while !isborder(robot, West)
        move!(robot, West)
    end

    while !isborder(robot, Ost)
        cells += 1
        move!(robot, Ost)
    end
    moveTillTheEnd(robot, West)
    return cells + 1
end

function width(robot)
    cells = 0
    while !isborder(robot, Nord)
        move!(robot, Nord)
    end

    while !isborder(robot, Sud)
        cells += 1
        move!(robot, Sud)
    end
    moveTillTheEnd(robot, Sud)
    return cells + 1
end

function moveTillTheEnd(robot, destination, markers=false)
    steps = 0
    while !isborder(robot, destination)
        if markers
            putmarker!(robot)
        end
        steps += 1
        move!(robot, destination)
    end
    if markers
        putmarker!(robot)
    end
    return steps
end


function moveSeveralCells(robot, number, side, markers=false)
    for i in 1:number
        if !isborder(robot, side)
            if markers
                putmarker!(robot)
            end
            move!(robot, side)
        end
        if markers
            putmarker!(robot)
        end
    end
end

function moveToCentre(robot)
    len = length(robot)
    wid = width(robot)
    for i in 1:(len // 2)
        move!(robot, Ost)
    end

    for i in 1:(wid // 2)
        move!(robot, Nord)
    end
end

function moveToStart(robot)
    while !isborder(robot, West)
        move!(robot, West)
    end

    while !isborder(robot, Sud)
        move!(robot, Sud)
    end
end

function moveToStartBarriersOn(robot::Robot)
    directions = Int[]
    while (!isborder(robot, Sud) || !isborder(robot, West))
        push!(directions, moveTillTheEnd(robot, West))
        push!(directions, moveTillTheEnd(robot, Sud))
    end
    return directions
end

function moveToInitial(robot::Robot, reversedArray::Vector)
    for i in 1:size(reversedArray)[1]
        if i % 2 == 0
            for x in 1:reversedArray[i]
                if !isborder(robot, Ost)
                    move!(robot, Ost)
                end
            end
        else
            for x in 1:reversedArray[i]
                if !isborder(robot, Nord)
                    move!(robot, Nord)
                end
            end
        end
    end
end

function moveBorderSide(robot::Robot, dir_side::HorizonSide, border_side::HorizonSide, markers=false) 
    steps = 0
    while isborder(robot, border_side)
        if markers
            putmarker!(robot)
        end
        if !isborder(robot, dir_side)
            move!(robot, dir_side)
            steps += 1
        end
    end

    if markers
        putmarker!(robot)
    end
    return steps
end

function turnAroundBorderSide(robot::Robot, side, markers=false) # Nord, West, Sud, Ost
    ortSide = HorizonSide(int(side) + 1 % 4)
    steps = moveBorderSide(robot, side, markers)
    moveBorderSide(robot, inverse(ortSide), markers)
    moveSeveralCells(robot, steps, inverse(ortSide), markers)
end

function moveTillTheEndBarriersOn(robot, side, len)
    steps = 1
    while len != steps
        steps += moveTillTheEnd(robot, side, true)
        if len != steps
            turnAroundBorderSide(robot, side, markers)
        end
    end
end

function inverse(side)
    if side == Sud
        return Nord
    end
    if side == Nord
        return Sud
    end
    if side == West
        return Ost
    end
    if side == Ost
        return West
    end
    
end


# function moveIsBorder(robot, side_border, side_dir, markers=false) # !!! повторяющийся код
#     while isborder(robot, side_border)
#         if markers
#             putmarker!(robot)
#         end

#         if !isborder(robot, side_dir)
#             move!(robot, side_dir)
#         end
#     end

#     if markers
#         putmarker!(robot)
#     end

#     if !isborder(robot, side_border)
#         return true
#     end
# end

# function goAroundBarrier(robot, side) # так как робота привожу в ю-в угол, то огибаю в сторону севера
#     moveIsSideBorder(robot, side, )
# end

function makeSnakeLineBarriersOn(robot)
    side = Ost
    horizontal = length(robot)
    vertical = width(robot)
    
    for i in 1:vertical
        moveTillTheEndBarriersOn(robot, side, horizontal)
    end
end
