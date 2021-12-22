using HorizonSideRobots
include("MainFunctions.jl")
include("MainStructures.jl")

r = Robot(animate = false, "temp15.sit")
border_robot = BorderRobot(r)
directions = moveToStartBarriersOn(r)
for i in 2:5
    moveTillTheEnd(border_robot, HorizonSide((i + 1) % 4), true)
end
moveToInitial(r, reverse(directions))