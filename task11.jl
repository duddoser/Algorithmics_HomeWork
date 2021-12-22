using HorizonSideRobots
include("MainFunctions.jl")
include("MainStructures.jl")

r = Robot(animate = false, "temp11.sit")
border_robot = BorderRobot(r)
for i in 0:3
    side = HorizonSide(i)
    steps = moveTillTheEnd(border_robot, side)
    putmarker!(r)
    moveSteps(border_robot, inverse(side), steps)
end
