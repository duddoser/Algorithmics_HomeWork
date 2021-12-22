using HorizonSideRobots
include("MainFunctions.jl")

r = Robot(animate = false, "temp18.sit")
directions = moveToStartBarriersOn(r)
for i in 2:5
    putmarker!(r)
    moveTillTheEnd(r, HorizonSide((i + 1) % 4))
end

moveToInitial(r, reverse(directions))
