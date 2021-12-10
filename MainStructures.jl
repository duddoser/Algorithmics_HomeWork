using HorizonSideRobots
include("MainFunctions.jl")

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

struct CoordRobot <: AbstractRobot
    robot::Robot
    coord::Coord
    CoordRobot(r) = new(r, Coord(0, 0))
end

get(r::CoordRobot) = r.robot

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

function getSideX(n::Int)::HorizonSide
    if n >= 0
        return Nord
    else
        return Sud
end

function getSideY(n::Int)::HorizonSide
    if n >= 0
        return Ost
    else
        return West
end

function move!(robot::CoordRobot, x::Int, y::Int)
    putmarker!(robot)
    side_x = getSideX(x)
    side_y = getSideY(y)
    for i in 1:abs(x)
        move!(get(robot), side_x)
        move!(robot.coord, side_x)
    end

    for j in 1:abs(y)
        move!(get(robot), side_y)
        move!(robot.coord, side_y)
end
