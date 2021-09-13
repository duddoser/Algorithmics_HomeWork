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

putMarkersTillTheEnd(r, Nord)
putMarkersTillTheEnd(r, Sud)

for _ in 1:(wid // 2)
    move!(r, Nord)
end

putMarkersTillTheEnd(r, West)
for _ in 1:(len // 2 - 1)
    move!(r, Ost)
end

show(r)
