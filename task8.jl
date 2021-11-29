using HorizonSideRobots
include("MainFunctions.jl")

steps = 1
while isborder(r, Nord)
    global steps
    moveSeveralCells(r, steps, West)
    if !isborder(r, Nord)
        break
    end
    steps += 1
    moveSeveralCells(r, steps, Ost)
    if !isborder(r, Nord)
        break
    end
    steps +=1
end
putmarker!(r)
