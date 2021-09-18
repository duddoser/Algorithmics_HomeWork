function length(robot)
    cells = 0
    while !isborder(robot, West)
        move!(robot, West)
    end

    while !isborder(robot, Ost)
        cells += 1
        move!(robot, Ost)
    end
    moveToStart(robot)
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
    moveToStart(robot)
    return cells + 1
end

function moveTillTheEnd(robot, destination, markers=false)
    steps = 0
    while !isborder(robot, destination)
        # if markers
        #     putmarker!(robot)
        # end 
        steps += 1
        move!(robot, destination)
    end
    if markers
        putmarker!(robot)
    end
    return steps
end

function moveToTheSud(robot)
    while !isborder(robot, Sud)
        move!(robot, Sud)
    end
end

function moveSeveralCells(robot, number, side)
    for i in 1:number
        if !isborder(robot, side)
            move!(robot, side)
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

