using HorizonSideRobots
include("MainFunctions.jl")

r = Robot(animate = false, "temp2.sit")
directions = moveToStartBarriersOn(r)
for i in 2:5
    moveTillTheEnd(r, HorizonSide((i + 1) % 4), true)
end
moveToInitial(r, reverse(directions))

# ENV["MPLBACKEND"]="tkagg"
# using PyPlot
# pygui(true)
