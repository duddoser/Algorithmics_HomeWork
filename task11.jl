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

struct BorderRobot <: AbstractRobot
    robot::Robot
end
get(r::BorderRobot) = r.robot

function move!(robot::BorderRobot, side::HorizonSide)
    if !isborder(get(robot), side)
        move!(get(robot), side)
    else
        ort_side = getOrtSide(side)
        steps = moveBorderSide(robot, ort_side, side)
        move!(robot, side)
        moveBorderSide(robot, side, inverse(ort_side))
        moveSeveralCells(robot, steps, inverse(ort_side))
    end
    nothing
end

function moveTillTheEnd(robot::BorderRobot, dir_side)
    steps = 0
    while !isEdge(get(robot), dir_side)
        steps += 1
        move!(robot, dir_side)
    end
    return steps
end

function moveSteps(robot::BorderRobot, dir_side, steps)
    for i in 1:steps
        move!(robot, dir_side)
    end
end

border_robot = BorderRobot(r)
for i in 0:3
    side = HorizonSide(i)
    steps = moveTillTheEnd(border_robot, side)
    putmarker!(r)
    moveSteps(border_robot, inverse(side), steps)
end
