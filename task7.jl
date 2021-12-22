using HorizonSideRobots
include("MainFunctions.jl")

r = Robot(animate = false, "temp7.sit")
directions = moveToStartBarriersOn(r) 
len = length(r)
wid = width(r)
parity = 0
if !isempty(directions)
    parity = (directions[1] + directions[2]) % 2
end

for i in 1:wid
    for j in 1:len
        if (i + j) % 2 == parity
            putmarker!(r)
        end
        if !isborder(r, Ost)
            move!(r, Ost)
        end
    end
    moveTillTheEnd(r, West)
    if !isborder(r, Nord)
        move!(r, Nord)
    end
end

moveToStart(r)
moveToInitial(r, reverse(directions))
