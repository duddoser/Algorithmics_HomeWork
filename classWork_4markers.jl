using HorizonSideRobots
include("MainFunctions.jl")

directions = Int[]
vertical = width(r)
horizontal = length(r)
moveToCentre(r)

while (!isborder(r, Sud) && !isborder(r, West))
    if !isborder(r, West)
        push!(directions, moveTillTheEnd(r, West))
    else !isborder(r, Sud)
        push!(directions, moveTillTheEnd(r, Sud))
    end
    n = moveTillTheEnd(r, Sud)
    if n != 0
        push!(directions, n)
    end
end

moveSeveralCells(r, vertical // 2, Nord)
putmarker!(r)
moveTillTheEnd(r, Nord)
moveSeveralCells(r, horizontal // 2, Ost)
putmarker!(r)
moveTillTheEnd(r, Ost)
moveSeveralCells(r, vertical // 2, Sud)
putmarker!(r)
moveTillTheEnd(r, Sud)
moveSeveralCells(r, horizontal // 2 - 1, West)
putmarker!(r)
moveTillTheEnd(r, West)

directions = reverse(directions)
for i in 1:size(directions)[1]
    if i % 2 != 0
        for x in 1:(directions[i] + 1)
            move!(r, Ost)
        end
    else
        for x in 1:(directions[i] - 1)
            move!(r, Nord)
        end
    end
end
