using HorizonSideRobots
include("MainFunctions.jl")

r = Robot()
len = length(r)
wid = width(r)

dir = Ost
for i in 1:wid
    for j in 1:len
        if (i + j) % 2 == 0
            putmarker!(r)
        end
        move!(r, dir)

    if isborder(r, dir)
        if !isborder(r, Nord)
            move!(r, Nord)
        end
        dir = reverse(dir)
    end
end
print("wtf")
show(r)
