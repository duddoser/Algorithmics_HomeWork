using HorizonSideRobots
include("MainFunctions.jl")
include("MainStructures.jl")

directions = moveToStartBarriersOn(r)
border_robot = BorderRobot(r)
len = length(r)
wid = width(r)

for i in 0:len - 1
    moveSteps(border_robot, Ost, wid - i, true)
    moveTillTheEnd(border_robot, West)
    if !isborder(r, Nord)
        move!(border_robot, Nord)
    end
    putmarker!(r)
end

moveToStartBarriersOn(r)
moveToInitial(r, reverse(directions))
