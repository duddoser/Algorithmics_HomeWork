using HorizonSideRobots
include("MainFunctions.jl")

directions = moveToStartBarriersOn(r)

while !isborder(r, Nord)
    moveTillTheEnd(r, Ost, true)
    move!(r, Nord)
    moveTillTheEnd(r, West, true)
end

moveTillTheEnd(r, Ost, true)
moveToStart(r)
moveToInitial(r, reverse(directions))
