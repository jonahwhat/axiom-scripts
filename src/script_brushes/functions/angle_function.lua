-- Angle function taken from here: https://github.com/WILLATRONIX/Axiom-Script-Brushes
-- Created by WILLATRONIX

--This script does not function as a brush, rather as a custom function like getBlock().
--getAngle(x, z, radius) returns the angle as a float.
--The radius of an angle is similar to smoothing, if there is no value for radius provided, it is defaulted to 2 (2 is the optimal value)

--Example: 
--if getAngle(x,z,4)=>45 then
--    return blocks.pink_wool
--end

--Final warning: the script does not account for y coordinates so only use for surface terrain

function getRadiusPositions(x, z, radius)
    local result = {}
    table.insert(result, {x + radius, z + radius})
    table.insert(result, {x + radius, z - radius})
    table.insert(result, {x - radius, z + radius})
    table.insert(result, {x - radius, z - radius})
    return result
end

function calculatePlaneNormal(point1, point2, point3, point4)
    local vectorFromPoints = function (p1, p2)
        return {p2[1] - p1[1], p2[2] - p1[2], p2[3] - p1[3]}
    end

    local crossProduct = function (v1, v2)
        return {
            v1[2] * v2[3] - v1[3] * v2[2],
            v1[3] * v2[1] - v1[1] * v2[3],
            v1[1] * v2[2] - v1[2] * v2[1]
        }
    end

    local normal1 = crossProduct(vectorFromPoints(point1, point2), vectorFromPoints(point1, point3))
    local normal2 = crossProduct(vectorFromPoints(point1, point3), vectorFromPoints(point1, point4))
    local normal3 = crossProduct(vectorFromPoints(point1, point4), vectorFromPoints(point1, point2))

    local normal = {
        (normal1[1] + normal2[1] + normal3[1]) / 3,
        (normal1[2] + normal2[2] + normal3[2]) / 3,
        (normal1[3] + normal2[3] + normal3[3]) / 3
    }

    local magnitude = math.sqrt(normal[1] * normal[1] + normal[2] * normal[2] + normal[3] * normal[3])
    if magnitude ~= 0 then
        normal = {normal[1] / magnitude, normal[2] / magnitude, normal[3] / magnitude}
    end

    return normal
end

function normalToAngle(normal)
    local alpha = math.acos(normal[1])
    local beta = math.asin(normal[2])
    alpha = math.deg(alpha) * -1
    beta = math.deg(beta) * -1
    return alpha, beta
end

function getSurfaceInAreaWithNormal(x, z, radius)
    local outerRadiusPositions = getRadiusPositions(x, z, radius)
    local corners = {}
    for _, point in ipairs(outerRadiusPositions) do
        local normalCornerX = point[1]
        local normalCornerY = getHighestBlockYAt(point[1], point[2])
        local normalCornerZ = point[2]
        table.insert(corners, {normalCornerX, normalCornerY, normalCornerZ})
    end
    return calculatePlaneNormal(corners[1], corners[2], corners[3], corners[4])
end

function getAngle(x, z, radius)
    if radius==nil then
        radius=2
    end
    local normal = getSurfaceInAreaWithNormal(x, z, radius)
    if normal then
        local alpha, beta = normalToAngle(normal)
        return beta
    else
        return false
    end
end
