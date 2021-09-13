using HorizonSideRobots
include("MainFunctions.jl")
# 3-Ost 1- West 2-Sud 0-Nord    
r = Robot()
moveToTheSud(r)
for i in 2:6
    putMarkersTillTheEnd(r, HorizonSide((i + 1) % 4))
end
show(r)
