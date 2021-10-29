using HorizonSideRobots
include("MainFunctions.jl")
# гориз - len, верт - wid

r = Robot()
wid, len = width(r), length(r)

moveSeveralCells(r, wid // 2, Nord)
moveTillTheEnd(r, Ost, true)
moveSeveralCells(r, len // 2, West)
moveTillTheEnd(r, Nord, true)
moveTillTheEnd(r, Sud, true)
moveSeveralCells(r, wid // 2, Nord)
show(r)
