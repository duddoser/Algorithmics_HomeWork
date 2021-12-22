using HorizonSideRobots
include("MainFunctions.jl")
include("MainStructures.jl")


border_robot = BorderRobot(r)
count_robot = CountBorderRobot(r, border_robot)
directions = moveToStartBarriersOn(r)
move!(r, Ost)
borders = 0

while !isEdge(r, Ost)
    global borders

    borders += moveTillTheEnd(count_robot, Nord)
    moveTillTheEnd(count_robot, Sud)
    move!(r, Ost)
end

println(borders)
moveToStartBarriersOn(r)
moveToInitial(r, reverse(directions))

