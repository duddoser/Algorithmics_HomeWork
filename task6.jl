using HorizonSideRobots
include("MainFunctions.jl")
global len
# 0 - Nord, 1 - West , 2 - Sud, 3 - Ost

directions = moveToStartBarriersOn(r)

while !isborder(r, Ost)
    if !isborder(r, Nord)
        move!(r, Nord)
    else
        moveTillTheEnd(r, Sud)
        if !isborder(r, Ost)
            move!(r, Ost)
        end
    end
end
direct_side = Nord
border_side = Ost
for i in 1:4
    global direct_side, border_side
    moveBorderSide(r, direct_side, border_side, true)
    direct_side = border_side
    border_side = HorizonSide((Int(border_side) + 3) % 4)
    move!(r, direct_side)
end 

moveToStart(r)
moveToInitial(r, reverse(directions))
