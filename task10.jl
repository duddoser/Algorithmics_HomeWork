using HorizonSideRobots
include("MainFunctions.jl")

r = Robot(animate = false, "temp10.sit")
counter_temp = 0
counter = 0
while !isborder(r, Nord) || !isborder(r, Ost)
    global counter, counter_temp
    while !isborder(r, Ost)
        if ismarker(r)
            counter += 1
            counter_temp += temperature(r)
        end
        move!(r, Ost)
    end
    if ismarker(r)
        counter += 1
        counter_temp += temperature(r)
    end
    if !isborder(r, Nord)
        move!(r, Nord)
        moveTillTheEnd(r, West)
    end
end 

println(counter_temp / counter)
