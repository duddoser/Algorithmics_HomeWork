abstract type AbstractRobot end

import HorizonSideRobots: move!, isborder, putmarker!, ismarker, temperature

move!(r::AbstractRobot, side) = move!(get(r), side)
isborder(r::AbstractRobot, side) = isborder(get(r), side)
putmarker!(r::AbstractRobot) = putmarker!(get(r))
ismarker(r::AbstractRobot) = ismarker(get(r))
temperature(r::AbstractRobot) = temperature(get(r))
moveToBorder!(r::AbstractRobot, side) = moveToBorder!(get(r), side)


struct PutmarkerRobot <: AbstractRobot
    robot::Robot
end

get(r::PutmarkerRobot) = r.robot

function move!(r::PutmarkerRobot, side)
    move!(get(r), side)
    putmarker!(get(r))
end
# julia using HorizonSideRobots
# r = Robot()
# include("classwork_8.jl")
# pmrobot = PutmarkerRobot(r)
# move!(pmrobot)

mutable struct CountMarkersRobot <: AbstractRobot 
    robot::Robot
    count::Int
end

get(r::CountMarkersRobot) = r.robot

function move!(r::CountMarkersRobot, side)
     move!(get(r), side)
     if ismarker(r)
        r.count += 1
     end
end

function moveToBorder!(r::AbstractRobot, side, steps)
    for _ in 1:steps
        move!(r, side)
    end
end

function try_move(r::Robot, side::HorizonSide)::Bool
    ort_side = HorizonSide((Int(side) + 1) % 4)
    n = 0
    while isborder(r, side)
        if !isborder(r, ort_side)
            move!(r, ort_side)
            n += 1
        else
            break
        end
    end
    if isborder(r, side)
        # нужно добавить шаги
        moveToBorder!(r, HorizonSide((Int(ort_side) + 2, n) % 4))
        return false
    end
    move!(r, side)
    while isborder(r, HorizonSide((Int(ort_side) + 2) % 4))
        move!(r, side)        
    end
    moveToBorder!(r, HorizonSide((Int(ort_side) + 2) % 4), n)
    return true
end

abstract type AbstractBorderRobot <: AbstractRobot end

get(r::AbstractBorderRobot) = r.robot

function try_move(r::AbstractBorderRobot, side::HorizonSide)
    result = try_move!(get(r), side)
    if result
        action(r) # - какая-то функиция
    end
    return result
end

function moveToBorder(r::AbstractBorderRobot, side::HorizonSide)
    n = 0
    while try_move(r, side)
        n += 1
    end
    return n
end

function moveToBorder(r::AbstractBorderRobot, side::HorizonSide, n::Int)
    for _ in 1:n
        try_move!(r, side)
    end
    return n
end

struct PutmarkersBorderRobot <: AbstractBorderRobot
    robot::Robot
end

get(r::PutmarkersBorderRobot) = r.robot

function try_move(r::PutmarkersBorderRobot, side::HorizonSide)
    result = try_move(get(r), side)
    if result
        putmarker!(r)
    end
    return result
end 

# ENV["MPLBACKEND"]="qt5agg"; using PyPlot; PyPlot.plot(rand(10)); PyPlot.ion(); PyPlot.show()
# pygui(true)