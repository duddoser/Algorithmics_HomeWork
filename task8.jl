using HorizonSideRobots
include("MainFunctions.jl")

r = Robot()
flag = moveIsBorder(r, Nord, Ost)
if !flag
    moveIsBorder(r, Nord, West)
end
show(r)
