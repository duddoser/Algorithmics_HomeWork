using HorizonSideRobots
include("MainFunctions.jl")
global len
# 0 - Nord, 1 - Ost, 2 - Sud, 3 - West 

r = Robot()
directions = moveToStartBarriersOn(r)
len = length(r)
w = width(r)
moveTillTheEnd(r, Ost)

for i in 2:(w + 1)
    steps = moveTillTheEnd(r, HorizonSide((i + 2) % 4))
    if len != steps # ура дошли
        moveBorderSide(r, Int(West), true)
        moveBorderSide(r, (i + 4) % 4, true)
        moveBorderSide(r, Int(Ost), true)
        moveBorderSide(r, Int(West), true)
    end
end
show!(r)
