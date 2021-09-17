using HorizonSideRobots
include("MainFunctions.jl")

r = Robot()
v = width(r)
moveToStart(r)

for i in 1:v
    if i % 2 != 0
        putMarkersTillTheEnd(r, Ost)
    else
        putMarkersTillTheEnd(r, West)
    end

    if !isborder(r, Nord)
        move!(r, Nord)
    end
end

moveToStart(r)
show(r)
