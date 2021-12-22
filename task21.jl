using HorizonSideRobots
include("MainFunctions.jl")
include("MainStructures.jl")

r = Robot(animate = false, "temp21.sit")
function countField(c_robot::CountBorderRobot, dir_side::HorizonSide, edge_side::HorizonSide)::Int64
    borders = 0
    while !isEdge(get(c_robot), edge_side)
        borders += moveTillTheEnd(c_robot, dir_side)
        moveTillTheEnd(c_robot, inverse(dir_side))
        move!(get(c_robot), edge_side)
    end
    return borders
end

border_robot = BorderRobot(r)
count_robot = CountBorderRobot(r, border_robot)
directions = moveToStartBarriersOn(r)
move!(r, Ost)
ans = 0
ans += countField(count_robot, Nord, Ost)

moveToStartBarriersOn(r)
move!(r, Nord)
ans += countField(count_robot, Ost, Nord)
println(ans)

moveToStartBarriersOn(r)
moveToInitial(r, reverse(directions))
