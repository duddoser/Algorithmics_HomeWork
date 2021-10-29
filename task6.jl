using HorizonSideRobots
include("MainFunctions.jl")
global len
# 0 - Nord, 1 - Ost, 2 - Sud, 3 - West 

r = Robot()
len = length(r)
moveToStart(r)
w = width(r)
moveTillTheEnd(r, Ost)

for i in 2:(w + 1)
    steps = moveTillTheEnd(r, HorizonSide((i + 2) % 4))
    if len != steps # ура дошли
        moveIsBorder(r, West, HorizonSide((i + 2) % 4), true)
        moveIsBorder(r, HorizonSide((i + 4) % 4), Ost, true)
        moveIsBorder(r, Ost, HorizonSide((i + 4) % 4), true)
        moveIsBorder(r, West, HorizonSide((i + 4) % 4), true)
    end
end
show(r)
