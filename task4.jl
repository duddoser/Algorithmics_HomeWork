using HorizonSideRobots
include("MainFunctions.jl")

r = Robot()
moveToStart(r)
len = length(r)
wid = width(r)

for i in 1:len
    moveSeveralCells(r, wid - i, Ost, true)
    if !isborder(r, Nord)
        move!(r, Nord)
    end
    moveTillTheEnd(r, West)
    putmarker!(r)
end

moveToStart(r)
show(r)
