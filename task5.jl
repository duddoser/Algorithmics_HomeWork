using HorizonSideRobots
include("MainFunctions.jl")

r = Robot()
moveToStart(r)
for i in 2:5
    putmarker!(r)
    moveTillTheEnd(r, HorizonSide((i + 1) % 4))
end

show(r)
