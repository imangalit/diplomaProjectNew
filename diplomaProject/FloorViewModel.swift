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
    private var rooms: [[Dot]] = [[],[],[],[],[],[]]
    private var connectors: [[Dot]] = [[],[],[],[],[],[]]
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
        if floor < rooms.count {
            return rooms[floor]
        }
        return []
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
        for floorIndex in 0..<rooms.count {
            for roomIndex in 0..<rooms[floorIndex].count {
                for connectedIndex in 0..<rooms[floorIndex][roomIndex].connected.count {
                    let roomV = rooms[floorIndex][roomIndex]
                    let roomToName = rooms[floorIndex][roomIndex].connected[connectedIndex]
                    for k in 0..<rooms.count {
                        if let roomTo = rooms[k].first(where: {$0.name == roomToName}) {
                            print(roomV.name)
                            print(roomTo.name)
                            allEdges.append(Edge(v: roomV, to: roomTo))
                            allEdges.append(Edge(v: roomTo, to: roomV))
                        }
                    }
                }
            }
        }
    }
    init() {
        let floor4Rooms: [Dot] = [Dot(name: "402room", x: 1784, y: 459, connected: []), Dot(name: "403room", x: 1784, y: 516, connected: []), Dot(name: "404room", x: 1724, y: 690, connected: []), Dot(name: "405aroom", x: 1636, y: 913, connected: []), Dot(name: "405broom", x: 1746, y: 913, connected: []), Dot(name: "406room", x: 1793, y: 937, connected: []), Dot(name: "410aroom", x: 1779, y: 1007, connected: []), Dot(name: "410room", x: 1783, y: 1210, connected: []), Dot(name: "411room", x: 1783, y: 1278, connected: []), Dot(name: "412room", x: 1783, y: 1345, connected: []), Dot(name: "414room", x: 1735, y: 1604, connected: []), Dot(name: "415room", x: 1783, y: 1412, connected: []), Dot(name: "416room", x: 1668, y: 1748, connected: []), Dot(name: "417room", x: 1738, y: 1748, connected: []), Dot(name: "419room", x: 1563, y: 913, connected: []), Dot(name: "420room", x: 1490, y: 913, connected: []), Dot(name: "421room", x: 1403, y: 913, connected: []), Dot(name: "422room", x: 1320, y: 913, connected: []), Dot(name: "424room", x: 1020, y: 960, connected: []), Dot(name: "425room", x: 1062, y: 868, connected: []), Dot(name: "426room", x: 1062, y: 787, connected: []), Dot(name: "427room", x: 1062, y: 715, connected: []), Dot(name: "428room", x: 1044, y: 674, connected: []), Dot(name: "435room", x: 972, y: 715, connected: []), Dot(name: "436room", x: 712, y: 914, connected: []), Dot(name: "438room", x: 522, y: 914, connected: []), Dot(name: "441room", x: 298, y: 764, connected: []), Dot(name: "444room", x: 277, y: 418, connected: []), Dot(name: "446room", x: 254, y: 468, connected: []), Dot(name: "447room", x: 254, y: 556, connected: []), Dot(name: "450room", x: 254, y: 676, connected: []), Dot(name: "451room", x: 254, y: 934, connected: []), Dot(name: "454room", x: 298, y: 1143, connected: []), Dot(name: "455room", x: 254, y: 1011, connected: []), Dot(name: "457room", x: 254, y: 1214, connected: []), Dot(name: "458room", x: 254, y: 1347, connected: []), Dot(name: "459room", x: 254, y: 1412, connected: []), Dot(name: "461room", x: 304, y: 1609, connected: []), Dot(name: "462room", x: 344, y: 1647, connected: []), Dot(name: "440room", x: 309, y: 553, connected: []), Dot(name: "465room", x: 832, y: 1850, connected: []), Dot(name: "466room", x: 781, y: 1828, connected: []), Dot(name: "468room", x: 788, y: 1763, connected: []), Dot(name: "470room", x: 1010, y: 1805, connected: []), Dot(name: "471room", x: 1247, y: 1828, connected: []), Dot(name: "472room", x: 1210, y: 1850, connected: []), Dot(name: "474room", x: 1247, y: 1763, connected: []), Dot(name: "476room", x: 1297, y: 1763, connected: []), Dot(name: "elevator4floorPanfilova", x: 1730, y: 1210, connected: []), Dot(name: "stairs4floorPanfilova", x: 1690, y: 1312, connected: []), Dot(name: "elevator4floorAbylaikhan", x: 306, y: 1214, connected: []), Dot(name: "stairs4floorAbylaikhan", x: 344, y: 1317, connected: []), Dot(name: "1elevator4floorTolebi", x: 1129, y: 1742, connected: []), Dot(name: "2elevator4floorTolebi", x: 915, y: 1740, connected: []), Dot(name: "1stairs4floorTolebi", x: 1062, y: 1673, connected: []), Dot(name: "2stairs4floorTolebi", x: 973, y: 1673, connected: [])]
        
        let floor0Rooms: [Dot] = [Dot(name: "1room", x: 1812, y: 196, connected: []), Dot(name: "2room", x: 1786, y: 217, connected: []), Dot(name: "3room", x: 1838, y: 262, connected: []), Dot(name: "4room", x: 1786, y: 305, connected: []), Dot(name: "5room", x: 1838, y: 330, connected: []), Dot(name: "6room", x: 1837, y: 446, connected: []), Dot(name: "8room", x: 1786, y: 519, connected: []), Dot(name: "9room", x: 1837, y: 581, connected: []), Dot(name: "10room", x: 1786, y: 578, connected: []), Dot(name: "11room", x: 1786, y: 649, connected: []), Dot(name: "12room", x: 1837, y: 653, connected: []), Dot(name: "13room", x: 1786, y: 716, connected: []), Dot(name: "14room", x: 1786, y: 779, connected: []), Dot(name: "15room", x: 1837, y: 750, connected: []), Dot(name: "16room", x: 1837, y: 849, connected: []), Dot(name: "18roomab", x: 1780, y: 859, connected: []), Dot(name: "19room", x: 1837, y: 916, connected: []), Dot(name: "22room", x: 1843, y: 1033, connected: []), Dot(name: "23room", x: 1840, y: 1137, connected: []), Dot(name: "24room", x: 1784, y: 1108, connected: []), Dot(name: "25room", x: 1842, y: 1252, connected: []), Dot(name: "26room", x: 1727, y: 1178, connected: []), Dot(name: "28room", x: 1843, y: 1347, connected: []), Dot(name: "29room", x: 1781, y: 1495, connected: []), Dot(name: "30room", x: 1842, y: 1448, connected: []), Dot(name: "31room1", x: 1842, y: 1550, connected: []), Dot(name: "31room2", x: 1842, y: 1657, connected: []), Dot(name: "33room", x: 1781, y: 1642, connected: []), Dot(name: "35room", x: 1781, y: 1700, connected: []), Dot(name: "36room", x: 1842, y: 1764, connected: []), Dot(name: "37room", x: 1890, y: 1798, connected: []), Dot(name: "38room", x: 1731, y: 1795, connected: []), Dot(name: "39room1", x: 1827, y: 1795, connected: []), Dot(name: "39room2", x: 1602, y: 1768, connected: []), Dot(name: "41room", x: 1466, y: 1825, connected: []), Dot(name: "42room", x: 1408, y: 1825, connected: []), Dot(name: "43room", x: 1570, y: 1880, connected: []), Dot(name: "44room", x: 1356, y: 1825, connected: []), Dot(name: "45room", x: 1306, y: 1825, connected: []), Dot(name: "46room1", x: 1243, y: 1825, connected: []), Dot(name: "46room2", x: 1213, y: 1878, connected: []), Dot(name: "47room", x: 1167, y: 1878, connected: []), Dot(name: "48room", x: 1121, y: 1878, connected: []), Dot(name: "49room", x: 1173, y: 1825, connected: []), Dot(name: "50room", x: 1074, y: 1877, connected: []), Dot(name: "51room", x: 1002, y: 1877, connected: []), Dot(name: "56room", x: 929, y: 1877, connected: []), Dot(name: "55room", x: 955, y: 1825, connected: []), Dot(name: "57room", x: 858, y: 1877, connected: []), Dot(name: "58room", x: 858, y: 1825, connected: []), Dot(name: "59room", x: 759, y: 1825, connected: []), Dot(name: "60room", x: 660, y: 1877, connected: []), Dot(name: "61room", x: 582, y: 1880, connected: []), Dot(name: "62room", x: 673, y: 1825, connected: []), Dot(name: "63room", x: 617, y: 1825, connected: []), Dot(name: "66room", x: 483, y: 1880, connected: []), Dot(name: "68room", x: 407, y: 1797, connected: []), Dot(name: "68aroom", x: 340, y: 1797, connected: []), Dot(name: "69room", x: 278, y: 1798, connected: []), Dot(name: "69aroom", x: 230, y: 1760, connected: []), Dot(name: "70room1", x: 313, y: 1701, connected: []), Dot(name: "70room2", x: 313, y: 1599, connected: []), Dot(name: "71room", x: 253, y: 1637, connected: []), Dot(name: "72room", x: 253, y: 1552, connected: []), Dot(name: "74room", x: 253, y: 1484, connected: []), Dot(name: "75room", x: 313, y: 1487, connected: []), Dot(name: "76room", x: 253, y: 1418, connected: []), Dot(name: "77room", x: 311, y: 1418, connected: []), Dot(name: "78room", x: 302, y: 1268, connected: []), Dot(name: "79room", x: 253, y: 1263, connected: []), Dot(name: "80room", x: 302, y: 1293, connected: []), Dot(name: "81room", x: 312, y: 1141, connected: []), Dot(name: "82room", x: 253, y: 1073, connected: []), Dot(name: "83room", x: 311, y: 1073, connected: []), Dot(name: "84room", x: 253, y: 998, connected: []), Dot(name: "85room", x: 312, y: 998, connected: []), Dot(name: "86room", x: 245, y: 678, connected: []), Dot(name: "90room", x: 257, y: 335, connected: []), Dot(name: "93room", x: 307, y: 308, connected: []), Dot(name: "94room", x: 257, y: 191, connected: []), Dot(name: "buffet0floorMain", x: 1044, y: 1600, connected: []), Dot(name: "stairs0floorTolebi", x: 1091, y: 1691, connected: []), Dot(name: "buffet0floorTolebi2", x: 1094, y: 1781, connected: []), Dot(name: "buffet0floorTolebi1", x: 1036, y: 1774, connected: []), Dot(name: "stairs0floorPanfilov", x: 1789, y: 1342, connected: ["stairs4floorPanfilova"]), Dot(name: "stairs0floorAbylaikhan", x: 302, y: 1348, connected: ["stairs4floorAbylaikhan"]), Dot(name: "elevators0floorAbylaikhan", x: 312, y: 1211, connected: []), Dot(name: "elevators0floorPanfilov", x: 1780, y: 1210, connected: [])]
        
        let floor4Connectors: [Dot] = [Dot(name: "1floor4", x: 1762, y: 459, connected: ["402room", "elevator4floorPanfilova"]), Dot(name: "2floor4", x: 1762, y: 519, connected: ["1floor4", "403room"]), Dot(name: "3floor4", x: 1762, y: 539, connected: ["2floor4"]), Dot(name: "4floor4", x: 1731, y: 539, connected: ["3floor4"]), Dot(name: "5floor4", x: 1687, y: 539, connected: ["4floor4"]), Dot(name: "6floor4", x: 1687, y: 690, connected: ["5floor4", "404room"]), Dot(name: "7floor4", x: 1687, y: 937, connected: ["6floor4"]), Dot(name: "8floor4", x: 1746, y: 937, connected: ["6floor4", "405broom", "406room"]), Dot(name: "9floor4", x: 1755, y: 1007, connected: ["8floor4", "410aroom"]), Dot(name: "10floor4", x: 1755, y: 1210, connected: ["9floor4", "410room"]), Dot(name: "11floor4", x: 1755, y: 1278, connected: ["10floor4", "411room"]), Dot(name: "12floor4", x: 1755, y: 1345, connected: ["11floor4", "412room"]), Dot(name: "13floor4", x: 1755, y: 1412, connected: ["12floor4", "415room"]), Dot(name: "14floor4", x: 1689, y: 1345, connected: ["12floor4","stairs4floorPanfilova"]), Dot(name: "15floor4", x: 1689, y: 1604, connected: ["14floor4", "414room", "415room"]), Dot(name: "17floor4", x: 1693, y: 1748, connected: ["15floor4", "416room", "417room"]), Dot(name: "18floor4", x: 1636, y: 934, connected: ["7floor4", "405aroom"]), Dot(name: "19floor4", x: 1563, y: 934, connected: ["18floor4", "419room"]), Dot(name: "20floor4", x: 1490, y: 934, connected: ["19floor4", "420room"]), Dot(name: "21floor4", x: 1403, y: 934, connected: ["20floor4", "421room"]), Dot(name: "22floor4", x: 1320, y: 934, connected: ["21floor4", "422room"]), Dot(name: "23floor4", x: 1020, y: 934, connected: ["22floor4", "424room"]), Dot(name: "24floor4", x: 1020, y: 868, connected: ["23floor4", "425room"]), Dot(name: "25floor4", x: 1020, y: 787, connected: ["24floor4", "426room"]), Dot(name: "26floor4", x: 1020, y: 715, connected: ["25floor4", "427room", "428room", "432room"]), Dot(name: "27floor4", x: 851, y: 934, connected: ["23floor4", "435room"]), Dot(name: "28floor4", x: 712, y: 935, connected: ["27floor4", "436room"]), Dot(name: "29floor4", x: 522, y: 935, connected: ["28floor4", "438room"]), Dot(name: "30floor4", x: 277, y: 934, connected: ["29floor4", "451room"]), Dot(name: "31floor4", x: 277, y: 764, connected: ["30floor4", "441room"]), Dot(name: "32floor4", x: 277, y: 676, connected: ["31floor4", "450room"]), Dot(name: "33floor4", x: 277, y: 553, connected: ["32floor4", "440room", "447room"]), Dot(name: "34floor4", x: 277, y: 468, connected: ["33floor4", "444room", "446room"]), Dot(name: "35floor4", x: 277, y: 1011, connected: ["30floor4", "455room"]), Dot(name: "36floor4", x: 277, y: 1143, connected: ["35floor4", "454room"]), Dot(name: "37floor4", x: 277, y: 1214, connected: ["36floor4", "457room", "elevator4floorAbylaikhan"]), Dot(name: "38floor4", x: 277, y: 1347, connected: ["37floor4", "458room"]), Dot(name: "39floor4", x: 277, y: 1412, connected: ["38floor4", "459room"]), Dot(name: "40floor4", x: 344, y: 1347, connected: ["38floor4"]), Dot(name: "41floor4", x: 344, y: 1609, connected: ["40floor4", "461room", "462room", "stairs4floorAbylaikhan"]), Dot(name: "42floor4", x: 1010, y: 1774, connected: ["43floor4", "44floor4", "47floor4"]), Dot(name: "43floor4", x: 832, y: 1777, connected: ["42floor4", "468room"]), Dot(name: "44floor4", x: 832, y: 1828, connected: ["43floor4", "465room", "466room"]), Dot(name: "45floor4", x: 1209, y: 1781, connected: ["42floor4", "474room"]), Dot(name: "46floor4", x: 1210, y: 1828, connected: ["46floor4", "471room", "472room"]), Dot(name: "47floor4", x: 1010, y: 1673, connected: ["1stairs4floorTolebi", "2stairs4floorTolebi"])]
        let floor0Connectors: [Dot] = [Dot(name: "1", x: 1812, y: 217, connected: ["1room", "2room"]), Dot(name: "2", x: 1811, y: 262, connected: ["1", "3room"]), Dot(name: "3", x: 1811, y: 305, connected: ["2", "4room"]), Dot(name: "4", x: 1811, y: 330, connected: ["3", "5room"]), Dot(name: "5", x: 1811, y: 446, connected: ["4", "6room"]), Dot(name: "6", x: 1811, y: 519, connected: ["5", "8room"]), Dot(name: "7", x: 1811, y: 578, connected: ["6", "10room", "9room"]), Dot(name: "8", x: 1811, y: 653, connected: ["7", "11room", "12room"]), Dot(name: "9", x: 1811, y: 716, connected: ["8", "13room"]), Dot(name: "10", x: 1811, y: 750, connected: ["9", "15room"]), Dot(name: "11", x: 1811, y: 779, connected: ["10", "14room"]), Dot(name: "12", x: 1811, y: 849, connected: ["11", "16room"]), Dot(name: "13", x: 1811, y: 859, connected: ["12", "18roomab"]), Dot(name: "14", x: 1811, y: 916, connected: ["13", "19room"]), Dot(name: "15", x: 1811, y: 1033, connected: ["14", "22room"]), Dot(name: "16", x: 1811, y: 1108, connected: ["15", "24room", "26room"]), Dot(name: "17", x: 1811, y: 1137, connected: ["16", "23room"]), Dot(name: "18", x: 1811, y: 1210, connected: ["17", "elevators0floorPanfilov"]), Dot(name: "19", x: 1811, y: 1252, connected: ["18", "25room"]), Dot(name: "20", x: 1811, y: 1342, connected: ["19", "28room", "stairs0floorPanfilov"]), Dot(name: "21", x: 1811, y: 1448, connected: ["20", "30room"]), Dot(name: "22", x: 1811, y: 1495, connected: ["21", "29room"]), Dot(name: "23", x: 1811, y: 1550, connected: ["22", "31room1"]), Dot(name: "24", x: 1811, y: 1642, connected: ["23", "33room"]), Dot(name: "25", x: 1811, y: 1657, connected: ["24", "31room2"]), Dot(name: "26", x: 1811, y: 1700, connected: ["25", "35room"]), Dot(name: "27", x: 1811, y: 1768, connected: ["26", "36room", "37room", "39room"]), Dot(name: "28", x: 1731, y: 1768, connected: ["27", "38room"]), Dot(name: "29", x: 1623, y: 1768, connected: ["28", "39room"]), Dot(name: "30", x: 1623, y: 1850, connected: ["29"]), Dot(name: "31", x: 1570, y: 1850, connected: ["30", "43room"]), Dot(name: "32", x: 1466, y: 1850, connected: ["31", "41room"]), Dot(name: "33", x: 1408, y: 1850, connected: ["32", "42room"]), Dot(name: "34", x: 1356, y: 1850, connected: ["33", "44room"]), Dot(name: "35", x: 1306, y: 1850, connected: ["34", "45room"]), Dot(name: "36", x: 1243, y: 1850, connected: ["35", "46room1"]), Dot(name: "37", x: 1213, y: 1850, connected: ["36", "46room2"]), Dot(name: "38", x: 1167, y: 1850, connected: ["37", "49room", "47room"]), Dot(name: "39", x: 1121, y: 1850, connected: ["38", "48room"]), Dot(name: "40", x: 1044, y: 1667, connected: ["41", "buffet0floorMain"]), Dot(name: "41", x: 1062, y: 1691, connected: ["42", "stairs0floorTolebi"]), Dot(name: "42", x: 1062, y: 1780, connected: ["43", "buffet0floorTolebi1", "buffet0floorTolebi2"]), Dot(name: "43", x: 1062, y: 1850, connected: ["44"]), Dot(name: "44", x: 1074, y: 1850, connected: ["39", "50room"]), Dot(name: "45", x: 1002, y: 1850, connected: ["44", "51room"]), Dot(name: "46", x: 955, y: 1850, connected: ["45", "55room"]), Dot(name: "47", x: 929, y: 1850, connected: ["46", "56room"]), Dot(name: "48", x: 858, y: 1850, connected: ["47", "57room", "58room"]), Dot(name: "49", x: 759, y: 1850, connected: ["48", "59room"]), Dot(name: "50", x: 673, y: 1850, connected: ["49", "62room"]), Dot(name: "51", x: 660, y: 1850, connected: ["50", "60room"]), Dot(name: "52", x: 617, y: 1850, connected: ["51", "63room"]), Dot(name: "53", x: 582, y: 1850, connected: ["52", "61room"]), Dot(name: "54", x: 483, y: 1850, connected: ["53", "66room"]), Dot(name: "55", x: 463, y: 1850, connected: ["54"]), Dot(name: "56", x: 463, y: 1767, connected: ["55"]), Dot(name: "57", x: 407, y: 1767, connected: ["56", "68room"]), Dot(name: "58", x: 340, y: 1767, connected: ["57", "68aroom"]), Dot(name: "59", x: 284, y: 1767, connected: ["58", "69room", "69aroom"]), Dot(name: "60", x: 284, y: 1701, connected: ["59", "70room1"]), Dot(name: "61", x: 284, y: 1637, connected: ["60", "71room"]), Dot(name: "62", x: 284, y: 1599, connected: ["61", "70room2"]), Dot(name: "63", x: 284, y: 1552, connected: ["62", "72room"]), Dot(name: "64", x: 285, y: 1484, connected: ["63", "75room", "74room"]), Dot(name: "65", x: 285, y: 1418, connected: ["64", "77room", "76room"]), Dot(name: "66", x: 285, y: 1348, connected: ["65", "stairs0floorAbylaikhan"]), Dot(name: "67", x: 285, y: 1293, connected: ["66", "79room"]), Dot(name: "68", x: 285, y: 1263, connected: ["67", "78room", "80room"]), Dot(name: "69", x: 285, y: 1211, connected: ["68", "elevators0floorAbylaikhan"]), Dot(name: "70", x: 285, y: 1141, connected: ["69", "81room"]), Dot(name: "71", x: 285, y: 1073, connected: ["70", "82room", "83room"]), Dot(name: "72", x: 285, y: 998, connected: ["71", "84room", "85room"]), Dot(name: "73", x: 285, y: 819, connected: ["72"]), Dot(name: "74", x: 275, y: 800, connected: ["73"]), Dot(name: "75", x: 275, y: 678, connected: ["74", "86room"]), Dot(name: "76", x: 275, y: 557, connected: ["75"]), Dot(name: "77", x: 281, y: 545, connected: ["76"]), Dot(name: "78", x: 281, y: 335, connected: ["77", "90room"]), Dot(name: "79", x: 281, y: 308, connected: ["78", "93room"]), Dot(name: "80", x: 281, y: 191, connected: ["79", "94room"])]
        
        rooms[0] = floor0Rooms
        rooms[4] = floor4Rooms
        connectors[0] = floor0Connectors
        connectors[4] = floor4Connectors
    }
    
    func getPath(_ from: Dot, _ to: Dot) -> [Dot] {
        var distance: [String: Double] = [:]
        var previous: [String: Dot] = [:]
        var queue: [Dot] = []
        print("from:", from)
        print("to:", to)
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


//
//#include <bits/stdc++.h>
//using namespace std;
//main() {
//    string name;
//    int x, y;
//    string connected;
//    while(cin >> name >> x >> y >> connected) {
//        string t;
//        string p;
//        for(int i = 0; i < connected.size(); i ++) {
//            if(connected[i] == ",") {
//                p += """;
//                p += t;
//                p += "", ";
//                t = "";
//                continue;
//            }
//            t += connected[i];
//        }
//        p += """;
//        p += t;
//        p += """;
//        cout<<"Dot(name: ""<<name<<"floor4", x: "<<x<<", y: "<<y<<", connected: ["<<p<<"]), ";
//    }
//
//    return 0;
//}

//
//#include <bits/stdc++.h>
//using namespace std;
//main() {
//    string name;
//    int x, y;
//    string connected;
//    while(cin >> name >> x >> y) {
//        string t;
//        string p;
//        p += """;
//        p += t;
//        p += """;
//        cout<<"Dot(name: ""<<name<<"", x: "<<x<<", y: "<<y<<", connected: []), ";
//    }
//
//    return 0;
//}
