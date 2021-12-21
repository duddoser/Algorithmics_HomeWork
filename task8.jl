using HorizonSideRobots
include("MainFunctions.jl")

steps = 1
while isborder(r, Nord)
    global steps
    for i in [West, Ost]
        moveSeveralCells(r, steps, i)
        if !isborder(r, Nord)
            break
        end
        steps += 1
    end
end
putmarker!(r)
