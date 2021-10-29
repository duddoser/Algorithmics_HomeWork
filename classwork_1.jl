using HorizonSideRobots
include("MainFunctions.jl")

r = Robot()
directions = moveToStartBarriersOn(r)
makeSnakeLineBarriersOn(r)
show(r)
