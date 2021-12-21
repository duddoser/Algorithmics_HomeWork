using HorizonSideRobots
include("MainFunctions.jl")

moveToStartBarriersOn(r)
wid, len = width(r), length(r)

moveSeveralCells(r, wid // 2, Nord)
moveSeveralCells(r, len // 2 - 1, Ost, true)

steps_nord = moveTillTheEnd(r, Nord, true)
moveTillTheEnd(r, Sud, true)

extra = wid % 2 == 0 ? wid - steps_nord - 1 : steps_nord 
moveSeveralCells(r, extra, Nord)

steps = moveTillTheEnd(r, Ost, true)
moveSeveralCells(r, steps, West) 
