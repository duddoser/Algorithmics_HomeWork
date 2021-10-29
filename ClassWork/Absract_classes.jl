using HorizonSideRobots
import HorizonSideRobots
abstract type AbstractRobot <: HorizonSideRobots end

function get(abstract_robot::AbstractRobot)
    return Robot(abstract_robot)
end

abstract type AbstractBorderRobot <: AbstractRobot end

function get(abstract_border_robot::AbstractBorderRobot)
    return Robot(abstract_border_robot)
end

function moveToBorder(robot::AbstractBorderRobot, side, markers=False)
    n = 0
    while !isborder(robot, side)
        if markers
            putmarker!(robot)
        end
        n++
        move!(robot, side)
    end
    if markers
        putmarker!(robot)
    end
    return n
end

function moveSeveralSteps(robot::AbstractBorderRobot, side, n::Int, markers)
    for i in 1:n
        if !isborder(robot, side)
            move!(robot, side)
            if markers
                putmarker!(robot)
            end
        end
    end
    if markers
        putmarker!(robot)
    end
end

function isBorderSide(robot::Robot, side) # Nord, West, Sud, Ost
    ortSide = HorizonSide(int(side) + 1 % 4)
    while isborder(robot, side)
        if !isborder(robot, ortSide)
            move!(robot, ortSide)
        else
            return false
    end
    return true
end

function makeSnakeLine(robot::AbstractRobot)
    # змейкаааа
    return 0
end

robot_border = AbstractBorderRobot()
robot = robot_border.get()
print("ok")
