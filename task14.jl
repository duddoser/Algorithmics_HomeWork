using HorizonSideRobots
include("MainFunctions.jl")
include("MainStructures.jl")

border_robot = BorderRobot(r)
moveToStartBarriersOn(r)
wid, len = width(r), length(r)

moveSteps(border_robot, Nord, wid // 2)
moveSteps(border_robot, Ost, len // 2 - 1, true)

steps_nord = moveTillTheEnd(border_robot, Nord, true)
moveTillTheEnd(border_robot, Sud, true)

extra = wid % 2 == 0 ? wid - steps_nord - 1 : steps_nord 
moveSteps(border_robot, Nord, extra)

steps = moveTillTheEnd(border_robot, Ost, true)
moveSteps(border_robot, West, steps) 
