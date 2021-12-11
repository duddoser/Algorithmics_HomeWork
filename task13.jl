using HorizonSideRobots
include("MainFunctions.jl")
include("MainStructures.jl")

moveToStart(r)

len = length(r)
wid = width(r)
min_value = min(len, wid)
cross_robot = CrossRobot(r)

move!(cross_robot, (min_value / 2, min_value / 2))
move!(coord_robot, (-min_value / 2, min_value / 2))
move!(coord_robot, (min_value, -min_value))
move!(coord_robot, (-min_value / 2, min_value / 2))
move!(coord_robot, (min_value / 2, min_value / 2))
