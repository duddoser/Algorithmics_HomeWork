using HorizonSideRobots
include("MainFunctions.jl")
include("MainStructures.jl")

r = Robot(animate = false, "temp16.sit")
directions = moveToStartBarriersOn(r)
v = width(r)
border_robot = BorderRobot(r)

for i in 1:v
    if i % 2 != 0
        moveTillTheEnd(border_robot, Ost, true)
    else
        moveTillTheEnd(border_robot, West, true)
    end

    if !isEdge(r, Nord)
        move!(border_robot, Nord)
    end
end

moveToStartBarriersOn(r)
moveToInitial(r, reverse(directions))
