using HorizonSideRobots
include("MainFunctions.jl")

directions = moveToStartBarriersOn(r)
for i in 2:5
    moveTillTheEnd(r, HorizonSide((i + 1) % 4), true)
end
moveToInitial(r, reverse(directions))

# ENV["MPLBACKEND"]="tkagg"
# using PyPlot
# pygui(true)
