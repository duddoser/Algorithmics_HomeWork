using HorizonSideRobots
include("MainFunctions.jl")

abstract type AbstractRobot end
import HorizonSideRobots: move!, isborder, putmarker!, ismarker, temperature

move!(r::AbstractRobot, side) = move!(get(r), side)
isborder(r::AbstractRobot, side) = isborder(get(r), side)
putmarker!(r::AbstractRobot) = putmarker!(get(r))
ismarker(r::AbstractRobot) = ismarker(get(r))
temperature(r::AbstractRobot) = temperature(get(r))
moveToBorder!(r::AbstractRobot, side) = moveToBorder!(get(r), side)

mutable struct Coord
    x::Int
    y::Int 
end

Coord() = Coord(0,0) 
get_coord(coord::Coord) = (coord.x, coord.y)

struct CrossRobot <: AbstractRobot
    robot::Robot
    coord::Coord
    CrossRobot(r) = new(r, Coord(0, 0))
end

get(r::CrossRobot) = r.robot

function move!(coord::Coord, side::HorizonSide)
    if side == Nord
        coord.y += 1
    elseif side == Sud
        coord.y -= 1
    elseif side == Ost
        coord.x += 1
    else 
        coord.x -= 1
    end
end

function getSideX(n::Float64)::HorizonSide
    if n >= 0
        return Ost
    else
        return West
    end
end

function getSideY(n::Float64)::HorizonSide
    if n >= 0
        return Nord
    else
        return Sud
    end
end

function move!(robot::CrossRobot, coords::Tuple{Float64, Float64})
    putmarker!(robot)
    x = coords[1]
    y = coords[2]
    side_x = getSideX(x)
    side_y = getSideY(y)
    for i in 1:abs(x)
        if !isborder(robot, side_x) & !isborder(robot, side_y)
            move!(get(robot), side_x)
            move!(robot.coord, side_x)
            move!(get(robot), side_y)
            move!(robot.coord, side_y)
            putmarker!(robot)
        end
    end
end

struct PutmarkerRobot <: AbstractRobot
    robot::Robot
end

get(r::PutmarkerRobot) = r.robot

function move!(r::PutmarkerRobot, side::HorizonSide)
    putmarker!(r)
    move(get(r), side)
    putmarker!(r)
end

struct BorderRobot <: AbstractRobot
    robot::Robot
end
get(r::BorderRobot) = r.robot

function move!(robot::BorderRobot, side::HorizonSide)
    dir_steps = 0
    if !isborder(get(robot), side)
        move!(get(robot), side)
    else
        ort_side = getOrtSide(side)
        steps = moveBorderSide(robot, ort_side, side)
        move!(get(robot), side)
        dir_steps = moveBorderSide(robot, side, inverse(ort_side))
        moveSeveralCells(get(robot), steps, inverse(ort_side))
    end
    return dir_steps
end

function moveTillTheEnd(robot::BorderRobot, dir_side, markers = false)
    steps = 0
    while !isEdge(get(robot), dir_side)
        if markers
            putmarker!(robot)
        end
        steps += move!(robot, dir_side) + 1
    end
    if markers
        putmarker!(robot)
    end
    return steps
end

function moveSteps(robot::BorderRobot, dir_side, steps, markers=false)
    border_steps = 0
    border_count = 0
    flag = true
    for i in 1:steps
        if markers
            putmarker!(robot)
        end
        cur_steps = move!(robot, dir_side)
        border_steps += cur_steps
        if cur_steps > 0 border_count += 1 end

        if i + border_steps > steps
            flag = false
            break
        end
    end
    if markers & flag
        putmarker!(robot)
    end
end

function moveToMarker(robot::BorderRobot, side::HorizonSide, markers=false)
    while !ismarker(robot) & !isEdge(get(robot), side)
        if markers
            putmarker!(robot)
        end
        move!(robot, side)
    end
end

function moveAround(robot::BorderRobot, side::HorizonSide, markers=false)
    if !isborder(robot, side)
        move!(robot, side)
    else
        putmarker!(robot)
        ort_side = getOrtSide(side)
        steps = moveBorderSide(robot, ort_side, side, markers)
        move!(get(robot), side)
        moveBorderSide(robot, side, inverse(ort_side), markers)
        move!(robot, inverse(ort_side))
        border_len = moveBorderSide(robot, inverse(ort_side), inverse(side), markers)
        move!(robot, inverse(side))
        moveBorderSide(robot, inverse(side), ort_side, markers)
        moveSteps(robot, ort_side, border_len - steps, markers)
        move!(robot, side)
    end
end

struct CountBorderRobot <: AbstractRobot
    robot::Robot
    border_robot::BorderRobot
end
get(r::CountBorderRobot) = r.robot
getBorderRobot(r::CountBorderRobot) = r.border_robot

function move!(robot::CountBorderRobot, side::HorizonSide)
    if !isborder(get(robot), side)
        move!(get(robot), side)
        return 0
    else
        move!(getBorderRobot(robot), side)
        return 1
    end
end

function moveTillTheEnd(robot::CountBorderRobot, dir_side::HorizonSide, markers=false)
    borders = 0
    while !isEdge(get(robot), dir_side)
        if markers
            putmarker!(robot)
        end
        
        if !isBarrierLeft(robot, dir_side, HorizonSide((Int(dir_side) + 1) % 4))
            borders += move!(robot, dir_side)
        else
            move!(robot, dir_side)
        end
    end
    if markers
        putmarker!(robot)
    end
    return borders
end
