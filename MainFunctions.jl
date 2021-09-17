function length(robot)
    cells = 0
    while !isborder(robot, West)
        move!(robot, West)
    end

    while !isborder(robot, Ost)
        cells += 1
        move!(robot, Ost)
    end
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
    return cells + 1
end

function putMarkersTillTheEnd(robot, destination)
    while !isborder(robot, destination)
        putmarker!(robot)
        move!(robot, destination)
    end
    putmarker!(robot)
end

function moveToTheSud(robot)
    while !isborder(robot, Sud)
        move!(robot, Sud)
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