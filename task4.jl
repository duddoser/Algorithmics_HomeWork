using HorizonSideRobots
include("MainFunctions.jl")

directions = moveToStartBarriersOn(r)
len = length(r)
wid = width(r)

for i in 0 : min(len, wid)
    moveSeveralCells(r, wid - i, Ost, true)
    if !isborder(r, Nord)
        move!(r, Nord)
    end
    moveTillTheEnd(r, West)
    putmarker!(r)
end

moveToStart(r)
moveToInitial(r, reverse(directions))
