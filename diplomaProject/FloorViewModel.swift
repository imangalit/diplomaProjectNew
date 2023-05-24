//
//  FloorViewModel.swift
//  diplomaProject
//
//  Created by Имангали on 5/22/23.
//

import Foundation

struct Dot {
    var name: String
    var x: Double
    var y: Double
    var connected: [String]
}
struct Edge {
    var v: Dot
    var to: Dot
}

class FloorViewModel {
    private var rooms: [[Dot]] = []
    private var connectors: [[Dot]] = []
    private var allEdges: [Edge] = []
    func getAllRooms() -> [Dot] {
        var allRooms: [Dot] = []
        for floor in rooms {
            for room in floor {
                allRooms.append(room)
            }
        }
        return allRooms
    }
    func getFloorRooms(_ floor: Int) -> [Dot] {
        return rooms[floor]
    }
    func getAllConnectors() -> [[Dot]] {
        return connectors
    }
    func getFloorConnectors(_ floor: Int) -> [Dot] {
        return connectors[floor]
    }
    func initRooms(_ frameWidth: Double, _ imageViewX: Double, _ imageViewY: Double) {
        for floorIndex in 0..<rooms.count {
            for roomIndex in 0..<rooms[floorIndex].count {
                var room = rooms[floorIndex][roomIndex]
                room.x *= frameWidth / 2100
                room.y *= frameWidth / 2100
                room.x += imageViewX
                room.y += imageViewY
                rooms[floorIndex][roomIndex] = room
            }
        }
        for floorIndex in 0..<connectors.count {
            for roomIndex in 0..<connectors[floorIndex].count {
                var room = connectors[floorIndex][roomIndex]
                room.x *= frameWidth / 2100
                room.y *= frameWidth / 2100
                room.x += imageViewX
                room.y += imageViewY
                connectors[floorIndex][roomIndex] = room
            }
        }
        for floorIndex in 0..<connectors.count {
            for roomIndex in 0..<connectors[floorIndex].count {
                for connectedIndex in 0..<connectors[floorIndex][roomIndex].connected.count {
                    let roomV = connectors[floorIndex][roomIndex]
                    let roomToName = connectors[floorIndex][roomIndex].connected[connectedIndex]
                    if let roomTo = connectors[floorIndex].first(where: {$0.name == roomToName}) {
                        allEdges.append(Edge(v: roomV, to: roomTo))
                        allEdges.append(Edge(v: roomTo, to: roomV))
                    }
                    else if let roomTo = rooms[floorIndex].first(where: {$0.name == roomToName}) {
                        allEdges.append(Edge(v: roomV, to: roomTo))
                        allEdges.append(Edge(v: roomTo, to: roomV))
                    }
                }
            }
        }
    }
    init() {
        let floor0Rooms: [Dot] = [Dot(name: "1room", x: 1812, y: 196, connected: []), Dot(name: "2room", x: 1786, y: 217, connected: []), Dot(name: "3room", x: 1838, y: 262, connected: []), Dot(name: "4room", x: 1786, y: 305, connected: []), Dot(name: "5room", x: 1838, y: 330, connected: []), Dot(name: "6room", x: 1837, y: 446, connected: []), Dot(name: "8room", x: 1786, y: 519, connected: []), Dot(name: "9room", x: 1837, y: 581, connected: []), Dot(name: "10room", x: 1786, y: 578, connected: []), Dot(name: "11room", x: 1786, y: 649, connected: []), Dot(name: "12room", x: 1837, y: 653, connected: []), Dot(name: "13room", x: 1786, y: 716, connected: []), Dot(name: "14room", x: 1786, y: 779, connected: []), Dot(name: "15room", x: 1837, y: 750, connected: []), Dot(name: "16room", x: 1837, y: 849, connected: []), Dot(name: "18roomab", x: 1780, y: 859, connected: []), Dot(name: "19room", x: 1837, y: 916, connected: []), Dot(name: "22room", x: 1843, y: 1033, connected: []), Dot(name: "23room", x: 1840, y: 1137, connected: []), Dot(name: "24room", x: 1784, y: 1108, connected: []), Dot(name: "25room", x: 1842, y: 1252, connected: []), Dot(name: "26room", x: 1727, y: 1178, connected: []), Dot(name: "28room", x: 1843, y: 1347, connected: []), Dot(name: "29room", x: 1781, y: 1495, connected: []), Dot(name: "30room", x: 1842, y: 1448, connected: []), Dot(name: "31room1", x: 1842, y: 1550, connected: []), Dot(name: "31room2", x: 1842, y: 1657, connected: []), Dot(name: "33room", x: 1781, y: 1642, connected: []), Dot(name: "35room", x: 1781, y: 1700, connected: []), Dot(name: "36room", x: 1842, y: 1764, connected: []), Dot(name: "37room", x: 1890, y: 1798, connected: []), Dot(name: "38room", x: 1731, y: 1795, connected: []), Dot(name: "39room1", x: 1827, y: 1795, connected: []), Dot(name: "39room2", x: 1602, y: 1768, connected: []), Dot(name: "41room", x: 1466, y: 1825, connected: []), Dot(name: "42room", x: 1408, y: 1825, connected: []), Dot(name: "43room", x: 1570, y: 1880, connected: []), Dot(name: "44room", x: 1356, y: 1825, connected: []), Dot(name: "45room", x: 1306, y: 1825, connected: []), Dot(name: "46room1", x: 1243, y: 1825, connected: []), Dot(name: "46room2", x: 1213, y: 1878, connected: []), Dot(name: "47room", x: 1167, y: 1878, connected: []), Dot(name: "48room", x: 1121, y: 1878, connected: []), Dot(name: "49room", x: 1173, y: 1825, connected: []), Dot(name: "50room", x: 1074, y: 1877, connected: []), Dot(name: "51room", x: 1002, y: 1877, connected: []), Dot(name: "56room", x: 929, y: 1877, connected: []), Dot(name: "55room", x: 955, y: 1825, connected: []), Dot(name: "57room", x: 858, y: 1877, connected: []), Dot(name: "58room", x: 858, y: 1825, connected: []), Dot(name: "59room", x: 759, y: 1825, connected: []), Dot(name: "60room", x: 660, y: 1877, connected: []), Dot(name: "61room", x: 582, y: 1880, connected: []), Dot(name: "62room", x: 673, y: 1825, connected: []), Dot(name: "63room", x: 617, y: 1825, connected: []), Dot(name: "66room", x: 483, y: 1880, connected: []), Dot(name: "68room", x: 407, y: 1797, connected: []), Dot(name: "68aroom", x: 340, y: 1797, connected: []), Dot(name: "69room", x: 278, y: 1798, connected: []), Dot(name: "69aroom", x: 230, y: 1760, connected: []), Dot(name: "70room1", x: 313, y: 1701, connected: []), Dot(name: "70room2", x: 313, y: 1599, connected: []), Dot(name: "71room", x: 253, y: 1637, connected: []), Dot(name: "72room", x: 253, y: 1552, connected: []), Dot(name: "74room", x: 253, y: 1484, connected: []), Dot(name: "75room", x: 313, y: 1487, connected: []), Dot(name: "76room", x: 253, y: 1418, connected: []), Dot(name: "77room", x: 311, y: 1418, connected: []), Dot(name: "78room", x: 302, y: 1268, connected: []), Dot(name: "79room", x: 253, y: 1263, connected: []), Dot(name: "80room", x: 302, y: 1293, connected: []), Dot(name: "81room", x: 312, y: 1141, connected: []), Dot(name: "82room", x: 253, y: 1073, connected: []), Dot(name: "83room", x: 311, y: 1073, connected: []), Dot(name: "84room", x: 253, y: 998, connected: []), Dot(name: "85room", x: 312, y: 998, connected: []), Dot(name: "86room", x: 245, y: 678, connected: []), Dot(name: "90room", x: 257, y: 335, connected: []), Dot(name: "93room", x: 307, y: 308, connected: []), Dot(name: "94room", x: 257, y: 191, connected: []), Dot(name: "buffet0floorMain", x: 1044, y: 1600, connected: []), Dot(name: "stairs0floorTolebi", x: 1091, y: 1691, connected: []), Dot(name: "buffet0floorTolebi2", x: 1094, y: 1781, connected: []), Dot(name: "buffet0floorTolebi1", x: 1036, y: 1774, connected: []), Dot(name: "stairs0floorPanfilov", x: 1789, y: 1342, connected: []), Dot(name: "stairs0floorAbylaikhan", x: 302, y: 1348, connected: []), Dot(name: "elevators0floorAbylaikhan", x: 312, y: 1211, connected: []), Dot(name: "elevators0floorPanfilov", x: 1780, y: 1210, connected: [])]
        rooms.append(floor0Rooms)
        
        let floor0Connectors: [Dot] = [Dot(name: "1", x: 1812, y: 217, connected: ["1room", "2room"]), Dot(name: "2", x: 1811, y: 262, connected: ["1", "3room"]), Dot(name: "3", x: 1811, y: 305, connected: ["2", "4room"]), Dot(name: "4", x: 1811, y: 330, connected: ["3", "5room"]), Dot(name: "5", x: 1811, y: 446, connected: ["4", "6room"]), Dot(name: "6", x: 1811, y: 519, connected: ["5", "8room"]), Dot(name: "7", x: 1811, y: 578, connected: ["6", "10room", "9room"]), Dot(name: "8", x: 1811, y: 653, connected: ["7", "11room", "12room"]), Dot(name: "9", x: 1811, y: 716, connected: ["8", "13room"]), Dot(name: "10", x: 1811, y: 750, connected: ["9", "15room"]), Dot(name: "11", x: 1811, y: 779, connected: ["10", "14room"]), Dot(name: "12", x: 1811, y: 849, connected: ["11", "16room"]), Dot(name: "13", x: 1811, y: 859, connected: ["12", "18roomab"]), Dot(name: "14", x: 1811, y: 916, connected: ["13", "19room"]), Dot(name: "15", x: 1811, y: 1033, connected: ["14", "22room"]), Dot(name: "16", x: 1811, y: 1108, connected: ["15", "24room", "26room"]), Dot(name: "17", x: 1811, y: 1137, connected: ["16", "23room"]), Dot(name: "18", x: 1811, y: 1210, connected: ["17", "elevators0floorPanfilov"]), Dot(name: "19", x: 1811, y: 1252, connected: ["18", "25room"]), Dot(name: "20", x: 1811, y: 1342, connected: ["19", "28room", "stairs0floorPanfilov"]), Dot(name: "21", x: 1811, y: 1448, connected: ["20", "30room"]), Dot(name: "22", x: 1811, y: 1495, connected: ["21", "29room"]), Dot(name: "23", x: 1811, y: 1550, connected: ["22", "31room1"]), Dot(name: "24", x: 1811, y: 1642, connected: ["23", "33room"]), Dot(name: "25", x: 1811, y: 1657, connected: ["24", "31room2"]), Dot(name: "26", x: 1811, y: 1700, connected: ["25", "35room"]), Dot(name: "27", x: 1811, y: 1768, connected: ["26", "36room", "37room", "39room"]), Dot(name: "28", x: 1731, y: 1768, connected: ["27", "38room"]), Dot(name: "29", x: 1623, y: 1768, connected: ["28", "39room"]), Dot(name: "30", x: 1623, y: 1850, connected: ["29"]), Dot(name: "31", x: 1570, y: 1850, connected: ["30", "43room"]), Dot(name: "32", x: 1466, y: 1850, connected: ["31", "41room"]), Dot(name: "33", x: 1408, y: 1850, connected: ["32", "42room"]), Dot(name: "34", x: 1356, y: 1850, connected: ["33", "44room"]), Dot(name: "35", x: 1306, y: 1850, connected: ["34", "45room"]), Dot(name: "36", x: 1243, y: 1850, connected: ["35", "46room1"]), Dot(name: "37", x: 1213, y: 1850, connected: ["36", "46room2"]), Dot(name: "38", x: 1167, y: 1850, connected: ["37", "49room", "47room"]), Dot(name: "39", x: 1121, y: 1850, connected: ["38", "48room"]), Dot(name: "40", x: 1044, y: 1667, connected: ["41", "buffet0floorMain"]), Dot(name: "41", x: 1062, y: 1691, connected: ["42", "stairs0floorTolebi"]), Dot(name: "42", x: 1062, y: 1780, connected: ["43", "buffet0floorTolebi1", "buffet0floorTolebi2"]), Dot(name: "43", x: 1062, y: 1850, connected: ["44"]), Dot(name: "44", x: 1074, y: 1850, connected: ["39", "50room"]), Dot(name: "45", x: 1002, y: 1850, connected: ["44", "51room"]), Dot(name: "46", x: 955, y: 1850, connected: ["45", "55room"]), Dot(name: "47", x: 929, y: 1850, connected: ["46", "56room"]), Dot(name: "48", x: 858, y: 1850, connected: ["47", "57room", "58room"]), Dot(name: "49", x: 759, y: 1850, connected: ["48", "59room"]), Dot(name: "50", x: 673, y: 1850, connected: ["49", "62room"]), Dot(name: "51", x: 660, y: 1850, connected: ["50", "60room"]), Dot(name: "52", x: 617, y: 1850, connected: ["51", "63room"]), Dot(name: "53", x: 582, y: 1850, connected: ["52", "61room"]), Dot(name: "54", x: 483, y: 1850, connected: ["53", "66room"]), Dot(name: "55", x: 463, y: 1850, connected: ["54"]), Dot(name: "56", x: 463, y: 1767, connected: ["55"]), Dot(name: "57", x: 407, y: 1767, connected: ["56", "68room"]), Dot(name: "58", x: 340, y: 1767, connected: ["57", "68aroom"]), Dot(name: "59", x: 284, y: 1767, connected: ["58", "69room", "69aroom"]), Dot(name: "60", x: 284, y: 1701, connected: ["59", "70room1"]), Dot(name: "61", x: 284, y: 1637, connected: ["60", "71room"]), Dot(name: "62", x: 284, y: 1599, connected: ["61", "70room2"]), Dot(name: "63", x: 284, y: 1552, connected: ["62", "72room"]), Dot(name: "64", x: 285, y: 1484, connected: ["63", "75room", "74room"]), Dot(name: "65", x: 285, y: 1418, connected: ["64", "77room", "76room"]), Dot(name: "66", x: 285, y: 1348, connected: ["65", "stairs0floorAbylaikhan"]), Dot(name: "67", x: 285, y: 1293, connected: ["66", "79room"]), Dot(name: "68", x: 285, y: 1263, connected: ["67", "78room", "80room"]), Dot(name: "69", x: 285, y: 1211, connected: ["68", "elevators0floorAbylaikhan"]), Dot(name: "70", x: 285, y: 1141, connected: ["69", "81room"]), Dot(name: "71", x: 285, y: 1073, connected: ["70", "82room", "83room"]), Dot(name: "72", x: 285, y: 998, connected: ["71", "84room", "85room"]), Dot(name: "73", x: 285, y: 819, connected: ["72"]), Dot(name: "74", x: 275, y: 800, connected: ["73"]), Dot(name: "75", x: 275, y: 678, connected: ["74", "86room"]), Dot(name: "76", x: 275, y: 557, connected: ["75"]), Dot(name: "77", x: 281, y: 545, connected: ["76"]), Dot(name: "78", x: 281, y: 335, connected: ["77", "90room"]), Dot(name: "79", x: 281, y: 308, connected: ["78", "93room"]), Dot(name: "80", x: 281, y: 191, connected: ["79", "94room"])]
        connectors.append(floor0Connectors)
    }
    
    func getPath(_ from: Dot, _ to: Dot) -> [Dot] {
        var distance: [String: Double] = [:]
        var previous: [String: Dot] = [:]
        var queue: [Dot] = []

        for room in getAllRooms() {
            if room.name == from.name {
                distance[room.name] = 0
                queue.append(room)
            } else {
                distance[room.name] = Double.infinity
            }
            previous[room.name] = nil
        }
        while !queue.isEmpty {
            queue.sort { distance[$0.name]! < distance[$1.name]! }
            let currentDot = queue.removeFirst()
            if currentDot.name == to.name {
                break
            }
            let neighborEdges = allEdges.filter({$0.v.name == currentDot.name})
            print("from", currentDot.name)
            print("to", neighborEdges)
            for neighborEdge in neighborEdges {
                let neighborDot = neighborEdge.to
                let distanceToNeighbor = (distance[currentDot.name] ?? Double.infinity) + calculateDistance(from: currentDot, to: neighborDot)
                if distanceToNeighbor < distance[neighborDot.name] ?? Double.infinity {
                    distance[neighborDot.name] = distanceToNeighbor
                    previous[neighborDot.name] = currentDot
                    queue.append(neighborDot)
                }
            }
        }
        var roomsInPath: [Dot] = []
        
        var currentDot = to
        while currentDot.name != "" {
            roomsInPath.append(currentDot)
            currentDot = previous[currentDot.name] ?? Dot(name: "", x: 0, y: 0, connected: [])
        }
        return roomsInPath
    }
    
    func getFloorOfDot(_ v: Dot) -> Int {
        for i in 0..<rooms.count {
            if rooms[i].contains(where: {$0.name == v.name}) { return i }
            if connectors[i].contains(where: {$0.name == v.name}) { return i }
        }
        return 0
    }
    
    func calculateDistance(from startDot: Dot, to endDot: Dot) -> Double {
        let xDiff = endDot.x - startDot.x
        let yDiff = endDot.y - startDot.y
        return hypot(xDiff, yDiff)
    }
}

