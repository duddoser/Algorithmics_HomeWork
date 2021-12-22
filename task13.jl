using HorizonSideRobots
include("MainFunctions.jl")
include("MainStructures.jl")

r = Robot(animate = false, "temp13.sit")
moveToStart(r)

len = length(r)
wid = width(r)
min_value = min(len, wid)
cross_robot = CrossRobot(r)
extra = 1 - min_value % 2

move!(cross_robot, (min_value / 2 - extra, min_value / 2 - extra))
move!(cross_robot, (-min_value / 2 + extra, min_value / 2 - extra))
move!(cross_robot, (min_value / 1 - extra, -min_value / 1 + extra))
move!(cross_robot, (-min_value / 2 + extra, min_value / 2 - extra))
move!(cross_robot, (min_value / 2 + extra, min_value / 2 + extra))
move!(cross_robot, (-min_value / 2, -min_value / 2))
