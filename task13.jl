using HorizonSideRobots
include("MainFunctions.jl")
include("MainStructures.jl")

moveToStart(r)

length = length(r)
coord_robot = CoordRobot(r)

for i in 1:length/2
    move!(coord_robot, 1, 1)
end

moveTillTheEnd()
