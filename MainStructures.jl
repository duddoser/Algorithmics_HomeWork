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
    for i in 1:steps
        if markers
            putmarker!(robot)
        end
        border_steps += move!(robot, dir_side)
        if i + border_steps >= steps
            break
        end
    end
    if markers
        putmarker!(robot)
    end
end
