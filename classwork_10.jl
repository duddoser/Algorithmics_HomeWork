using HorizonSideRobots
include("lib_for_practic_10.jl")

function extRectangle(robot, side::HorizonSide)
    for _ in 1:4
        movements!(robot, side)
        side = left(side)
    end
end


function innerRectangle(robot, side::HorizonSide)
    for _ in 1:4
        bord_side = left(side)
        movements!(() -> isborder(robot, bord_side), robot, side)
        side = bord_side
        move!(robot, side)
    end
end
# $ xtjulia