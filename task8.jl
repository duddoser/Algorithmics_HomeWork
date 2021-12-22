using HorizonSideRobots
include("MainFunctions.jl")

r = Robot(animate = false, "temp8.sit")
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
