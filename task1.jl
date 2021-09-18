using HorizonSideRobots
include("MainFunctions.jl")
# гориз - len, верт - wid


r = Robot()
wid, len = width(r), length(r)
for i in 1:(wid // 2)
    move!(r, Nord)
end

for _ in 1:(len // 2)
    putmarker!(r)
    move!(r, West)
end

moveTillTheEnd(r, Nord, true)
moveTillTheEnd(r, Sud, true)

for _ in 1:(wid // 2)
    move!(r, Nord)
end

moveTillTheEnd(r, West, true)
for _ in 1:(len // 2 - 1)
    move!(r, Ost)
end

show(r)
