using HorizonSideRobots
include("MainFunctions.jl")

r = Robot()
moveToStart(r)
for i in 2:5
    moveTillTheEnd(r, HorizonSide((i + 1) % 4), true)
end
show(r)
