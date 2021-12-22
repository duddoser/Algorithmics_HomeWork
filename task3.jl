using HorizonSideRobots
include("MainFunctions.jl")

r = Robot(animate = false, "temp3.sit")
directions = moveToStartBarriersOn(r)

while !isborder(r, Nord)
    moveTillTheEnd(r, Ost, true)
    move!(r, Nord)
    moveTillTheEnd(r, West, true)
end

moveTillTheEnd(r, Ost, true)
moveToStart(r)
moveToInitial(r, reverse(directions))
