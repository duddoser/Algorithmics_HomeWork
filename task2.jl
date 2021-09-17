using HorizonSideRobots
include("MainFunctions.jl")

r = Robot()
moveToStart(r)
for i in 2:5
    putMarkersTillTheEnd(r, HorizonSide((i + 1) % 4))
end
show(r)
