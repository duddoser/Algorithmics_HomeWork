using HorizonSideRobots
include("MainFunctions.jl")

directions = moveToStartBarriersOn(r)
v = width(r)

for i in 1:v
    if i % 2 != 0
        moveTillTheEnd(r, Ost, true)
    else
        moveTillTheEnd(r, West, true)
    end

    if !isborder(r, Nord)
        move!(r, Nord)
    end
end

moveToStart(r)
moveToInitial(r, reverse(directions))
