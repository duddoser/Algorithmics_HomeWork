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

function moveTillTheEnd(robot::Robot, destination, markers=false)
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


function moveSeveralCells(robot::Robot, number, side, markers=false)
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

function moveBorderSide(robot, dir_side::HorizonSide, border_side::HorizonSide, markers=false) 
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

function moveSpiral(robot)
    steps = 1
    side = Ost
    while !ismarker(robot)
        for i in 1:steps
            moveIsMarker(robot, side)
        end
        side = HorizonSide((Int(side) + 1) % 4)
        for i in 1:steps
            moveIsMarker(robot, side)
        end
        side = HorizonSide((Int(side) + 1) % 4)
        steps += 1
    end
end


function makeSnakeLine(robot, side)
    moveTillTheEnd(robot, side)
    while !isborder(robot, Nord) || !isborder(robot, West)
        side = inverse(side)
        moveTillTheEnd(robot, side)
    end
end

function moveIsMarker(robot, side_dir::HorizonSide)
    if !ismarker(robot)
        move!(robot, side_dir)
        return true
    end
    return false
end

function getOrtSide(side)
    return HorizonSide((Int(side) + 1) % 4)
end

function isEdge(robot::Robot, dir_side)
    ort_side = getOrtSide(dir_side)
    steps = moveTillTheEnd(robot, ort_side)
    flag = isborder(robot, ort_side) & isborder(robot, dir_side)
    moveSeveralCells(robot, steps, inverse(ort_side))
    if flag
        return true
    else
        return false
    end
end
