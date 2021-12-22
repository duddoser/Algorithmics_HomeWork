using HorizonSideRobots
include("MainFunctions.jl")

r = Robot(animate = false, "temp1.sit")
moveToStartBarriersOn(r)

wid, len = width(r), length(r)

moveSeveralCells(r, wid // 2, Nord)
moveSeveralCells(r, len // 2 - (1 - len % 2), Ost, true)
putmarker!(r)

moveTillTheEnd(r, Nord)
moveToMarker(r, Sud, true)
moveTillTheEnd(r, Sud)
moveToMarker(r, Nord, true)

moveTillTheEnd(r, Ost)
moveToMarker(r, West, true)
