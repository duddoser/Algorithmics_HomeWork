using HorizonSideRobots

r = Robot()
for i in 1:5
    move!(r, Ost)
end

for i in 1:10
    putmarker!(r)
    move!(r, Nord)
end
putmarker!(r)

for i in 1:3
    move!(r, Sud)
end

for i in 1:5
    putmarker!(r)
    move!(r, West)
end

for i in 1:11
    putmarker!(r)
    move!(r, Ost)
end
putmarker!(r)

for i in 1:6
    putmarker!(r)
    move!(r, )
end

show(r)
