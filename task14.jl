using HorizonSideRobots
include("MainFunctions.jl")
include("MainStructures.jl")

r = Robot(animate = false, "temp14.sit")
border_robot = BorderRobot(r)
moveToStartBarriersOn(r)
wid, len = width(r), length(r)

moveSteps(border_robot, Nord, wid // 2)
moveSteps(border_robot, Ost, len // 2 - (1 - len % 2), true)
putmarker!(r)

moveTillTheEnd(border_robot, Nord)
moveToMarker(border_robot, Sud, true)
moveTillTheEnd(border_robot, Sud)
moveToMarker(border_robot, Nord, true)

moveTillTheEnd(border_robot, Ost)
moveToMarker(border_robot, West, true)
