using HorizonSideRobots
include("MainFunctions.jl")

r = Robot()
moveToCentre(r)
directions = moveToStartBarriersOn(r)
vertical = width(r)
horizontal = length(r)
show(r)

# moveSeveralCells(r, vertical // 2, Nord)
# putmarker!(r)
# moveTillTheEnd(r, Nord)
# moveSeveralCells(r, horizontal // 2, Ost)
# putmarker!(r)
# moveTillTheEnd(r, Ost)
# moveSeveralCells(r, vertical // 2, Sud)
# putmarker!(r)
# moveTillTheEnd(r, Sud)
# moveSeveralCells(r, horizontal // 2 - 1, West)
# putmarker!(r)
# moveTillTheEnd(r, West)

# moveToInitial(r, reverse(directions))
