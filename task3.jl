using HorizonSideRobots

r = Robot()
while !isborder(r, Nord)
    putmarker!(r)
    move!(r, Nord)
end

function moverOst()
    while !isborder(r, Ost)
        putmarker!(r)
        move!(r, Ost)
    end
    putmarker!(r)
    move!(r, Sud)
end

function moverWest()
    while !isborder(r, West)
        putmarker!(r)
        move!(r, West)
    end
    putmarker!(r)
    move!(r, Sud)
end

for i in 1:5
    moverOst()
    moverWest()
end

while !isborder(r, Ost)
    move!(r, Ost)
    putmarker!(r)
end

show(r)
