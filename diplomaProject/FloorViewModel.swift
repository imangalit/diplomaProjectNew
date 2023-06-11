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
                            allEdges.append(Edge(v: roomV, to: roomTo))
                            allEdges.append(Edge(v: roomTo, to: roomV))
                        }
                    }
                }
            }
        }
    }
    init() {
        let floor5Rooms: [Dot] = [Dot(name: "502r", x: 358, y: 1087, connected: []), Dot(name: "503r", x: 470, y: 1015, connected: []), Dot(name: "504r", x: 470, y: 1079, connected: []), Dot(name: "505r", x: 588, y: 1014, connected: []), Dot(name: "506r", x: 588, y: 1079, connected: []), Dot(name: "507r", x: 659, y: 1015, connected: []), Dot(name: "508r", x: 766, y: 1079, connected: []), Dot(name: "509r", x: 799, y: 1015, connected: []), Dot(name: "510r", x: 910, y: 1079, connected: []), Dot(name: "511r", x: 1054, y: 1079, connected: []), Dot(name: "512r", x: 1199, y: 1079, connected: []), Dot(name: "513r", x: 1054, y: 1008, connected: []), Dot(name: "514r", x: 1332, y: 1015, connected: []), Dot(name: "515r", x: 1431, y: 1015, connected: []), Dot(name: "516r", x: 1506, y: 1015, connected: []), Dot(name: "517r", x: 1332, y: 1079, connected: []), Dot(name: "518r", x: 1466, y: 1079, connected: []), Dot(name: "519r", x: 1617, y: 1015, connected: []), Dot(name: "521r", x: 1617, y: 1079, connected: []), Dot(name: "522r", x: 1868, y: 1008, connected: []), Dot(name: "523r", x: 1866, y: 1083, connected: [])]
        
        let floor4Rooms: [Dot] = [Dot(name: "402r", x: 1784, y: 459, connected: []), Dot(name: "403r", x: 1784, y: 516, connected: []), Dot(name: "404r", x: 1724, y: 690, connected: []), Dot(name: "405ar", x: 1636, y: 913, connected: []), Dot(name: "405br", x: 1746, y: 913, connected: []), Dot(name: "406r", x: 1793, y: 937, connected: []), Dot(name: "410ar", x: 1779, y: 1007, connected: []), Dot(name: "410r", x: 1783, y: 1210, connected: []), Dot(name: "411r", x: 1783, y: 1278, connected: []), Dot(name: "412r", x: 1783, y: 1345, connected: []), Dot(name: "414r", x: 1735, y: 1604, connected: []), Dot(name: "415r", x: 1783, y: 1412, connected: []), Dot(name: "416r", x: 1668, y: 1748, connected: []), Dot(name: "417r", x: 1738, y: 1748, connected: []), Dot(name: "419r", x: 1563, y: 913, connected: []), Dot(name: "420r", x: 1490, y: 913, connected: []), Dot(name: "421r", x: 1403, y: 913, connected: []), Dot(name: "422r", x: 1320, y: 913, connected: []), Dot(name: "424r", x: 1020, y: 960, connected: []), Dot(name: "425r", x: 1062, y: 868, connected: []), Dot(name: "426r", x: 1062, y: 787, connected: []), Dot(name: "427r", x: 1062, y: 715, connected: []), Dot(name: "428r", x: 1044, y: 674, connected: []), Dot(name: "435r", x: 972, y: 715, connected: []), Dot(name: "436r", x: 712, y: 914, connected: []), Dot(name: "438r", x: 522, y: 914, connected: []), Dot(name: "441r", x: 298, y: 764, connected: []), Dot(name: "444r", x: 277, y: 418, connected: []), Dot(name: "446r", x: 254, y: 468, connected: []), Dot(name: "447r", x: 254, y: 556, connected: []), Dot(name: "450r", x: 254, y: 676, connected: []), Dot(name: "451r", x: 254, y: 934, connected: []), Dot(name: "454r", x: 298, y: 1143, connected: []), Dot(name: "455r", x: 254, y: 1011, connected: []), Dot(name: "457r", x: 254, y: 1214, connected: []), Dot(name: "458r", x: 254, y: 1347, connected: []), Dot(name: "459r", x: 254, y: 1412, connected: []), Dot(name: "461r", x: 304, y: 1609, connected: []), Dot(name: "462r", x: 344, y: 1647, connected: []), Dot(name: "440r", x: 309, y: 553, connected: []), Dot(name: "465r", x: 832, y: 1850, connected: []), Dot(name: "466r", x: 781, y: 1828, connected: []), Dot(name: "468r", x: 788, y: 1763, connected: []), Dot(name: "470r", x: 1010, y: 1805, connected: []), Dot(name: "471r", x: 1247, y: 1828, connected: []), Dot(name: "472r", x: 1210, y: 1850, connected: []), Dot(name: "474r", x: 1247, y: 1763, connected: []), Dot(name: "476r", x: 1297, y: 1763, connected: [])]
        
        let floor2Rooms: [Dot] = [Dot(name: "216ar", x: 1778, y: 237, connected: []), Dot(name: "216br", x: 1830, y: 237, connected: []), Dot(name: "215r", x: 1778, y: 360, connected: []), Dot(name: "218r", x: 1830, y: 378, connected: []), Dot(name: "220r", x: 1830, y: 452, connected: []), Dot(name: "217r", x: 1778, y: 597, connected: []), Dot(name: "219r", x: 1778, y: 721, connected: []), Dot(name: "222r", x: 1830, y: 540, connected: []), Dot(name: "224r", x: 1830, y: 625, connected: []), Dot(name: "226r", x: 1830, y: 740, connected: []), Dot(name: "228r", x: 1830, y: 927, connected: []), Dot(name: "222/5/6r", x: 1680, y: 907, connected: []), Dot(name: "222/4r", x: 1567, y: 869, connected: []), Dot(name: "221r", x: 1756, y: 957, connected: []), Dot(name: "230r", x: 1830, y: 1011, connected: []), Dot(name: "231r", x: 1782, y: 1145, connected: []), Dot(name: "232r", x: 1830, y: 1224, connected: []), Dot(name: "233r", x: 1785, y: 1486, connected: []), Dot(name: "235r", x: 1785, y: 1554, connected: []), Dot(name: "237r", x: 1785, y: 1622, connected: []), Dot(name: "238r", x: 1785, y: 1693, connected: []), Dot(name: "234r", x: 1833, y: 1486, connected: []), Dot(name: "236r", x: 1833, y: 1554, connected: []), Dot(name: "239r", x: 1833, y: 1622, connected: []), Dot(name: "240r", x: 1833, y: 1693, connected: []), Dot(name: "243r", x: 1757, y: 1792, connected: []), Dot(name: "245r", x: 1620, y: 1876, connected: []), Dot(name: "242r", x: 1804, y: 1792, connected: []), Dot(name: "241r", x: 1850, y: 1815, connected: []), Dot(name: "249r", x: 1233, y: 1872, connected: []), Dot(name: "247r", x: 1259, y: 1819, connected: []), Dot(name: "250ar", x: 998, y: 1623, connected: []), Dot(name: "250br", x: 1092, y: 1623, connected: []), Dot(name: "251r", x: 848, y: 1792, connected: []), Dot(name: "251ar", x: 872, y: 1876, connected: []), Dot(name: "251br", x: 832, y: 1847, connected: []), Dot(name: "252r", x: 465, y: 1879, connected: []), Dot(name: "254ar", x: 410, y: 1791, connected: []), Dot(name: "254br", x: 280, y: 1791, connected: []), Dot(name: "255r", x: 201, y: 1642, connected: []), Dot(name: "256r", x: 254, y: 1610, connected: []), Dot(name: "258r", x: 254, y: 1488, connected: []), Dot(name: "257/259r", x: 307, y: 1488, connected: []), Dot(name: "260r", x: 254, y: 1209, connected: []), Dot(name: "264r", x: 196, y: 1108, connected: []), Dot(name: "262r", x: 363, y: 1174, connected: []), Dot(name: "261r", x: 310, y: 1144, connected: []), Dot(name: "263r", x: 254, y: 1075, connected: []), Dot(name: "265r", x: 254, y: 1006, connected: []), Dot(name: "268r", x: 381, y: 932, connected: []), Dot(name: "269r", x: 338, y: 904, connected: []), Dot(name: "270r", x: 254, y: 932, connected: []), Dot(name: "272r", x: 309, y: 783, connected: []), Dot(name: "273r", x: 309, y: 720, connected: []), Dot(name: "274r", x: 309, y: 657, connected: []), Dot(name: "275r", x: 357, y: 625, connected: []), Dot(name: "278r", x: 309, y: 531, connected: []), Dot(name: "271r", x: 254, y: 696, connected: []), Dot(name: "277r", x: 223, y: 520, connected: []), Dot(name: "279r", x: 254, y: 451, connected: []), Dot(name: "281r", x: 306, y: 376, connected: []), Dot(name: "280r", x: 254, y: 391, connected: []), Dot(name: "284r", x: 254, y: 242, connected: []), Dot(name: "283r", x: 312, y: 163, connected: []), Dot(name: "732r", x: 1176, y: 1568, connected: []), Dot(name: "726r", x: 858, y: 934, connected: []), Dot(name: "276r", x: 254, y: 696, connected: [])]
        
        let floor0Rooms: [Dot] = [Dot(name: "1r", x: 1812, y: 196, connected: []), Dot(name: "2r", x: 1786, y: 217, connected: []), Dot(name: "3r", x: 1838, y: 262, connected: []), Dot(name: "4r", x: 1786, y: 305, connected: []), Dot(name: "5r", x: 1838, y: 330, connected: []), Dot(name: "6r", x: 1837, y: 446, connected: []), Dot(name: "8r", x: 1786, y: 519, connected: []), Dot(name: "9r", x: 1837, y: 581, connected: []), Dot(name: "10r", x: 1786, y: 578, connected: []), Dot(name: "11r", x: 1786, y: 649, connected: []), Dot(name: "12r", x: 1837, y: 653, connected: []), Dot(name: "13r", x: 1786, y: 716, connected: []), Dot(name: "14r", x: 1786, y: 779, connected: []), Dot(name: "15r", x: 1837, y: 750, connected: []), Dot(name: "16r", x: 1837, y: 849, connected: []), Dot(name: "18rab", x: 1780, y: 859, connected: []), Dot(name: "19r", x: 1837, y: 916, connected: []), Dot(name: "22r", x: 1843, y: 1033, connected: []), Dot(name: "23r", x: 1840, y: 1137, connected: []), Dot(name: "24r", x: 1784, y: 1108, connected: []), Dot(name: "25r", x: 1842, y: 1252, connected: []), Dot(name: "26r", x: 1727, y: 1178, connected: []), Dot(name: "28r", x: 1843, y: 1347, connected: []), Dot(name: "29r", x: 1781, y: 1495, connected: []), Dot(name: "30r", x: 1842, y: 1448, connected: []), Dot(name: "31r1", x: 1842, y: 1550, connected: []), Dot(name: "31r2", x: 1842, y: 1657, connected: []), Dot(name: "33r", x: 1781, y: 1642, connected: []), Dot(name: "35r", x: 1781, y: 1700, connected: []), Dot(name: "36r", x: 1842, y: 1764, connected: []), Dot(name: "37r", x: 1890, y: 1798, connected: []), Dot(name: "38r", x: 1731, y: 1795, connected: []), Dot(name: "39r1", x: 1827, y: 1795, connected: []), Dot(name: "39r2", x: 1602, y: 1768, connected: []), Dot(name: "41r", x: 1466, y: 1825, connected: []), Dot(name: "42r", x: 1408, y: 1825, connected: []), Dot(name: "43r", x: 1570, y: 1880, connected: []), Dot(name: "44r", x: 1356, y: 1825, connected: []), Dot(name: "45r", x: 1306, y: 1825, connected: []), Dot(name: "46r1", x: 1243, y: 1825, connected: []), Dot(name: "46r2", x: 1213, y: 1878, connected: []), Dot(name: "47r", x: 1167, y: 1878, connected: []), Dot(name: "48r", x: 1121, y: 1878, connected: []), Dot(name: "49r", x: 1173, y: 1825, connected: []), Dot(name: "50r", x: 1074, y: 1877, connected: []), Dot(name: "51r", x: 1002, y: 1877, connected: []), Dot(name: "56r", x: 929, y: 1877, connected: []), Dot(name: "55r", x: 955, y: 1825, connected: []), Dot(name: "57r", x: 858, y: 1877, connected: []), Dot(name: "58r", x: 858, y: 1825, connected: []), Dot(name: "59r", x: 759, y: 1825, connected: []), Dot(name: "60r", x: 660, y: 1877, connected: []), Dot(name: "61r", x: 582, y: 1880, connected: []), Dot(name: "62r", x: 673, y: 1825, connected: []), Dot(name: "63r", x: 617, y: 1825, connected: []), Dot(name: "66r", x: 483, y: 1880, connected: []), Dot(name: "68r", x: 407, y: 1797, connected: []), Dot(name: "68ar", x: 340, y: 1797, connected: []), Dot(name: "69r", x: 278, y: 1798, connected: []), Dot(name: "69ar", x: 230, y: 1760, connected: []), Dot(name: "70r1", x: 313, y: 1701, connected: []), Dot(name: "70r2", x: 313, y: 1599, connected: []), Dot(name: "71r", x: 253, y: 1637, connected: []), Dot(name: "72r", x: 253, y: 1552, connected: []), Dot(name: "74r", x: 253, y: 1484, connected: []), Dot(name: "75r", x: 313, y: 1487, connected: []), Dot(name: "76r", x: 253, y: 1418, connected: []), Dot(name: "77r", x: 311, y: 1418, connected: []), Dot(name: "78r", x: 302, y: 1268, connected: []), Dot(name: "79r", x: 253, y: 1263, connected: []), Dot(name: "80r", x: 302, y: 1293, connected: []), Dot(name: "81r", x: 312, y: 1141, connected: []), Dot(name: "82r", x: 253, y: 1073, connected: []), Dot(name: "83r", x: 311, y: 1073, connected: []), Dot(name: "84r", x: 253, y: 998, connected: []), Dot(name: "85r", x: 312, y: 998, connected: []), Dot(name: "86r", x: 245, y: 678, connected: []), Dot(name: "90r", x: 257, y: 335, connected: []), Dot(name: "93r", x: 307, y: 308, connected: []), Dot(name: "94r", x: 257, y: 191, connected: [])]
        
        let floor5Connectors: [Dot] = [Dot(name: "1cf5", x: 358, y: 1047, connected: ["502r", "elevators5floor1", "stairs0floor1"]), Dot(name: "2cf5", x: 470, y: 1047, connected: ["1cf5", "503r", "504r"]), Dot(name: "3cf5", x: 588, y: 1047, connected: ["2cf5", "505r", "506r"]), Dot(name: "4cf5", x: 659, y: 1047, connected: ["3cf5", "507r"]), Dot(name: "5cf5", x: 766, y: 1047, connected: ["4cf5", "508r"]), Dot(name: "6cf5", x: 799, y: 1047, connected: ["5cf5", "509r"]), Dot(name: "7cf5", x: 910, y: 1047, connected: ["6cf5", "510r"]), Dot(name: "8cf5", x: 932, y: 1047, connected: ["7cf5"]), Dot(name: "9cf5", x: 932, y: 916, connected: ["8cf5", "elevators5floor2"]), Dot(name: "10cf5", x: 1054, y: 1047, connected: ["8cf5", "513r", "511r"]), Dot(name: "11cf5", x: 1165, y: 1047, connected: ["10cf5"]), Dot(name: "12cf5", x: 1165, y: 915, connected: ["11cf5", "elevators5floor3"]), Dot(name: "13cf5", x: 1199, y: 1047, connected: ["11cf5", "512r"]), Dot(name: "14cf5", x: 1332, y: 1047, connected: ["13cf5", "514r", "517r"]), Dot(name: "15cf5", x: 1431, y: 1047, connected: ["14cf5", "515r"]), Dot(name: "16cf5", x: 1466, y: 1047, connected: ["15cf5", "518r"]), Dot(name: "17cf5", x: 1506, y: 1047, connected: ["16cf5", "516r"]), Dot(name: "18cf5", x: 1617, y: 1047, connected: ["17cf5", "519r", "521r"]), Dot(name: "19cf5", x: 1735, y: 1047, connected: ["18cf5", "stairs0floor2"]), Dot(name: "20cf5", x: 1804, y: 1047, connected: ["19cf5", "elevators5cf4"]), Dot(name: "21cf5", x: 1866, y: 1048, connected: ["20cf5", "522r", "523r"])]
        
        let floor4Connectors: [Dot] = [Dot(name: "1cf4", x: 1762, y: 459, connected: ["402r", "elevator4floorPanfilova"]), Dot(name: "2cf4", x: 1762, y: 519, connected: ["1cf4", "403r"]), Dot(name: "3cf4", x: 1762, y: 539, connected: ["2cf4"]), Dot(name: "4cf4", x: 1731, y: 539, connected: ["3cf4"]), Dot(name: "5cf4", x: 1687, y: 539, connected: ["4cf4"]), Dot(name: "6cf4", x: 1687, y: 690, connected: ["5cf4", "404r"]), Dot(name: "7cf4", x: 1687, y: 937, connected: ["6cf4"]), Dot(name: "8cf4", x: 1746, y: 937, connected: ["6cf4", "405br", "406r"]), Dot(name: "9cf4", x: 1755, y: 1007, connected: ["8cf4", "410ar"]), Dot(name: "10cf4", x: 1755, y: 1210, connected: ["9cf4", "410r"]), Dot(name: "11cf4", x: 1755, y: 1278, connected: ["10cf4", "411r"]), Dot(name: "12cf4", x: 1755, y: 1345, connected: ["11cf4", "412r"]), Dot(name: "13cf4", x: 1755, y: 1412, connected: ["12cf4", "415r"]), Dot(name: "14cf4", x: 1689, y: 1345, connected: ["12cf4", "stairs4floorPanfilova"]), Dot(name: "15cf4", x: 1689, y: 1604, connected: ["14cf4", "414r", "415r"]), Dot(name: "17cf4", x: 1693, y: 1748, connected: ["15cf4", "416r", "417r"]), Dot(name: "18cf4", x: 1636, y: 934, connected: ["7cf4", "405ar"]), Dot(name: "19cf4", x: 1563, y: 934, connected: ["18cf4", "419r"]), Dot(name: "20cf4", x: 1490, y: 934, connected: ["19cf4", "420r"]), Dot(name: "21cf4", x: 1403, y: 934, connected: ["20cf4", "421r"]), Dot(name: "22cf4", x: 1320, y: 934, connected: ["21cf4", "422r"]), Dot(name: "23cf4", x: 1020, y: 934, connected: ["22cf4", "424r"]), Dot(name: "24cf4", x: 1020, y: 868, connected: ["23cf4", "425r"]), Dot(name: "25cf4", x: 1020, y: 787, connected: ["24cf4", "426r"]), Dot(name: "26cf4", x: 1020, y: 715, connected: ["25cf4", "427r", "428r", "432r"]), Dot(name: "27cf4", x: 851, y: 934, connected: ["23cf4", "435r"]), Dot(name: "28cf4", x: 712, y: 935, connected: ["27cf4", "436r"]), Dot(name: "29cf4", x: 522, y: 935, connected: ["28cf4", "438r"]), Dot(name: "30cf4", x: 277, y: 934, connected: ["29cf4", "451r"]), Dot(name: "31cf4", x: 277, y: 764, connected: ["30cf4", "441r"]), Dot(name: "32cf4", x: 277, y: 676, connected: ["31cf4", "450r"]), Dot(name: "33cf4", x: 277, y: 553, connected: ["32cf4", "440r", "447r"]), Dot(name: "34cf4", x: 277, y: 468, connected: ["33cf4", "444r", "446r"]), Dot(name: "35cf4", x: 277, y: 1011, connected: ["30cf4", "455r"]), Dot(name: "36cf4", x: 277, y: 1143, connected: ["35cf4", "454r"]), Dot(name: "37cf4", x: 277, y: 1214, connected: ["36cf4", "457r", "elevator4floorAbylaikhan"]), Dot(name: "38cf4", x: 277, y: 1347, connected: ["37cf4", "458r"]), Dot(name: "39cf4", x: 277, y: 1412, connected: ["38cf4", "459r"]), Dot(name: "40cf4", x: 344, y: 1347, connected: ["38cf4", "stairs4floorAbylaikhan"]), Dot(name: "41cf4", x: 344, y: 1609, connected: ["40cf4", "461r", "462r"]), Dot(name: "42cf4", x: 1010, y: 1774, connected: ["43cf4", "44cf4", "47cf4"]), Dot(name: "43cf4", x: 832, y: 1777, connected: ["42cf4", "468r"]), Dot(name: "44cf4", x: 832, y: 1828, connected: ["43cf4", "465r", "466r"]), Dot(name: "45cf4", x: 1209, y: 1781, connected: ["42cf4", "474r"]), Dot(name: "46cf4", x: 1210, y: 1828, connected: ["46cf4", "471r", "472r"]), Dot(name: "47cf4", x: 1010, y: 1673, connected: ["1stairs4floorTolebi", "2stairs4floorTolebi"])]
        
        let floor2Connectors: [Dot] = [Dot(name: "1cf2", x: 1804, y: 237, connected: ["216ar", "216br"]), Dot(name: "2cf2", x: 1804, y: 308, connected: ["1cf2"]), Dot(name: "3cf2", x: 1804, y: 375, connected: ["2cf2", "215r", "218r"]), Dot(name: "4cf2", x: 1804, y: 452, connected: ["3cf2", "220r", "stairs2floorPanfilov"]), Dot(name: "5cf2", x: 1804, y: 540, connected: ["4cf2", "217r", "222r"]), Dot(name: "6cf2", x: 1804, y: 628, connected: ["5cf2", "224r"]), Dot(name: "7cf2", x: 1804, y: 721, connected: ["6cf2", "219r", "226r"]), Dot(name: "8cf2", x: 1804, y: 927, connected: ["7cf2", "228r"]), Dot(name: "9cf2", x: 1756, y: 927, connected: ["8cf2", "221r"]), Dot(name: "10cf2", x: 1680, y: 927, connected: ["9cf2", "222/5/6r", "222/4r"]), Dot(name: "11cf2", x: 1804, y: 1011, connected: ["8cf2", "230r"]), Dot(name: "12cf2", x: 1804, y: 1065, connected: ["11cf2"]), Dot(name: "13cf2", x: 1804, y: 1146, connected: ["12cf2", "231r"]), Dot(name: "14cf2", x: 1804, y: 1224, connected: ["13cf2", "232r", "elevators2floorPanfilov"]), Dot(name: "15cf2", x: 1804, y: 1349, connected: ["14cf2"]), Dot(name: "16cf2", x: 1804, y: 1486, connected: ["15cf2", "233r", "234r"]), Dot(name: "17cf2", x: 1804, y: 1554, connected: ["16cf2", "235r", "236r"]), Dot(name: "18cf2", x: 1804, y: 1622, connected: ["17cf2", "237r", "239r"]), Dot(name: "19cf2", x: 1804, y: 1693, connected: ["18cf2", "238r", "240r"]), Dot(name: "20cf2", x: 1804, y: 1760, connected: ["19cf2", "242r", "241r"]), Dot(name: "21cf2", x: 1757, y: 1760, connected: ["20cf2", "243r"]), Dot(name: "22cf2", x: 1620, y: 1760, connected: ["21cf2"]), Dot(name: "23cf2", x: 1620, y: 1847, connected: ["22cf2"]), Dot(name: "24cf2", x: 1620, y: 1876, connected: ["23cf2", "245r"]), Dot(name: "25cf2", x: 1564, y: 1847, connected: ["23cf2"]), Dot(name: "26cf2", x: 1524, y: 1847, connected: ["25cf2"]), Dot(name: "27cf2", x: 1341, y: 1847, connected: ["249r"]), Dot(name: "28cf2", x: 1259, y: 1850, connected: ["27cf2", "247r"]), Dot(name: "29cf2", x: 1219, y: 1850, connected: ["28cf2"]), Dot(name: "30cf2", x: 1219, y: 1792, connected: ["29cf2"]), Dot(name: "31cf2", x: 1170, y: 1792, connected: ["30cf2"]), Dot(name: "32cf2", x: 1050, y: 1792, connected: ["31cf2"]), Dot(name: "33cf2", x: 1050, y: 1706, connected: ["32cf2"]), Dot(name: "34cf2", x: 1050, y: 1637, connected: ["33cf2", "250ar", "250br", "732r"]), Dot(name: "35cf2", x: 946, y: 1792, connected: ["32cf2"]), Dot(name: "36cf2", x: 872, y: 1792, connected: ["35cf2", "251r"]), Dot(name: "37cf2", x: 872, y: 1847, connected: ["36cf2", "251br", "251ar"]), Dot(name: "38cf2", x: 557, y: 1842, connected: ["39cf2"]), Dot(name: "497", x: 1845, y: 38, connected: ["cf2"]), Dot(name: "40cf2", x: 465, y: 1845, connected: ["39cf2", "252r"]), Dot(name: "41cf2", x: 465, y: 1763, connected: ["40cf2"]), Dot(name: "42cf2", x: 410, y: 1763, connected: ["41cf2", "254ar"]), Dot(name: "43cf2", x: 280, y: 1763, connected: ["42cf2", "254br"]), Dot(name: "44cf2", x: 280, y: 1672, connected: ["43", "cf2", "257/259r", "255r"]), Dot(name: "45cf2", x: 280, y: 1610, connected: ["44cf2", "256r"]), Dot(name: "46cf2", x: 280, y: 1491, connected: ["45cf2", "258r"]), Dot(name: "47cf2", x: 280, y: 1361, connected: ["46cf2"]), Dot(name: "48cf2", x: 280, y: 1209, connected: ["47cf2", "260r"]), Dot(name: "49cf2", x: 280, y: 1144, connected: ["48cf2", "261r", "262r"]), Dot(name: "50cf2", x: 280, y: 1075, connected: ["49cf2", "263r", "264r"]), Dot(name: "51cf2", x: 280, y: 1006, connected: ["50cf2", "265r"]), Dot(name: "52cf2", x: 280, y: 929, connected: ["51cf2", "270r"]), Dot(name: "53cf2", x: 335, y: 932, connected: ["52cf2", "268r", "269r"]), Dot(name: "54cf2", x: 280, y: 783, connected: ["52cf2", "272r", "271r"]), Dot(name: "55cf2", x: 280, y: 696, connected: ["54cf2", "273r"]), Dot(name: "56cf2", x: 280, y: 657, connected: ["55cf2", "274r", "276r", "275r"]), Dot(name: "57cf2", x: 280, y: 533, connected: ["56cf2", "278r", "277r"]), Dot(name: "58cf2", x: 280, y: 451, connected: ["57cf2", "279r"]), Dot(name: "59cf2", x: 280, y: 364, connected: ["58cf2", "281r", "280r"]), Dot(name: "60cf2", x: 280, y: 197, connected: ["59cf2", "284r", "283r"])]
        
        let floor0Connectors: [Dot] = [Dot(name: "1cf0", x: 1812, y: 217, connected: ["1r", "2r"]), Dot(name: "2cf0", x: 1811, y: 262, connected: ["1cf0", "3r"]), Dot(name: "3cf0", x: 1811, y: 305, connected: ["2cf0", "4r"]), Dot(name: "4cf0", x: 1811, y: 330, connected: ["3cf0", "5r"]), Dot(name: "5cf0", x: 1811, y: 446, connected: ["4cf0", "6r"]), Dot(name: "6cf0", x: 1811, y: 519, connected: ["5cf0", "8r"]), Dot(name: "7cf0", x: 1811, y: 578, connected: ["6cf0", "10r", "9r"]), Dot(name: "8cf0", x: 1811, y: 653, connected: ["7cf0", "11r", "12r"]), Dot(name: "9cf0", x: 1811, y: 716, connected: ["8cf0", "13r"]), Dot(name: "10cf0", x: 1811, y: 750, connected: ["9cf0", "15r"]), Dot(name: "11cf0", x: 1811, y: 779, connected: ["10cf0", "14r"]), Dot(name: "12cf0", x: 1811, y: 849, connected: ["11cf0", "16r"]), Dot(name: "13cf0", x: 1811, y: 859, connected: ["12cf0", "18rab"]), Dot(name: "14cf0", x: 1811, y: 916, connected: ["13cf0", "19r"]), Dot(name: "15cf0", x: 1811, y: 1033, connected: ["14cf0", "22r"]), Dot(name: "16cf0", x: 1811, y: 1108, connected: ["15cf0", "24r", "26r"]), Dot(name: "17cf0", x: 1811, y: 1137, connected: ["16cf0", "23r"]), Dot(name: "18cf0", x: 1811, y: 1210, connected: ["17cf0", "elevators0floorPanfilov"]), Dot(name: "19cf0", x: 1811, y: 1252, connected: ["18cf0", "25r"]), Dot(name: "20cf0", x: 1811, y: 1342, connected: ["19cf0", "28r", "stairs0floorPanfilov"]), Dot(name: "21cf0", x: 1811, y: 1448, connected: ["20cf0", "30r"]), Dot(name: "22cf0", x: 1811, y: 1495, connected: ["21cf0", "29r"]), Dot(name: "23cf0", x: 1811, y: 1550, connected: ["22cf0", "31r1"]), Dot(name: "24cf0", x: 1811, y: 1642, connected: ["23cf0", "33r"]), Dot(name: "25cf0", x: 1811, y: 1657, connected: ["24cf0", "31r2"]), Dot(name: "26cf0", x: 1811, y: 1700, connected: ["25cf0", "35r"]), Dot(name: "27cf0", x: 1811, y: 1768, connected: ["26cf0", "36r", "37r", "39r"]), Dot(name: "28cf0", x: 1731, y: 1768, connected: ["27cf0", "38r"]), Dot(name: "29cf0", x: 1623, y: 1768, connected: ["28cf0", "39r"]), Dot(name: "30cf0", x: 1623, y: 1850, connected: ["29cf0"]), Dot(name: "31cf0", x: 1570, y: 1850, connected: ["30cf0", "43r"]), Dot(name: "32cf0", x: 1466, y: 1850, connected: ["31cf0", "41r"]), Dot(name: "33cf0", x: 1408, y: 1850, connected: ["32cf0", "42r"]), Dot(name: "34cf0", x: 1356, y: 1850, connected: ["33cf0", "44r"]), Dot(name: "35cf0", x: 1306, y: 1850, connected: ["34cf0", "45r"]), Dot(name: "36cf0", x: 1243, y: 1850, connected: ["35cf0", "46r1"]), Dot(name: "37cf0", x: 1213, y: 1850, connected: ["36cf0", "46r2"]), Dot(name: "38cf0", x: 1167, y: 1850, connected: ["37cf0", "49r", "47r"]), Dot(name: "39cf0", x: 1121, y: 1850, connected: ["38cf0", "48r"]), Dot(name: "40cf0", x: 1044, y: 1667, connected: ["41cf0", "buffet0floorMain"]), Dot(name: "41cf0", x: 1062, y: 1691, connected: ["42cf0", "stairs0floorTolebi"]), Dot(name: "42cf0", x: 1062, y: 1780, connected: ["43cf0", "buffet0floorTolebi1", "buffet0floorTolebi2"]), Dot(name: "43cf0", x: 1062, y: 1850, connected: ["44cf0"]), Dot(name: "44cf0", x: 1074, y: 1850, connected: ["39cf0", "50r"]), Dot(name: "45cf0", x: 1002, y: 1850, connected: ["44cf0", "51r"]), Dot(name: "46cf0", x: 955, y: 1850, connected: ["45cf0", "55r"]), Dot(name: "47cf0", x: 929, y: 1850, connected: ["46cf0", "56r"]), Dot(name: "48cf0", x: 858, y: 1850, connected: ["47cf0", "57r", "58r"]), Dot(name: "49cf0", x: 759, y: 1850, connected: ["48cf0", "59r"]), Dot(name: "50cf0", x: 673, y: 1850, connected: ["49cf0", "62r"]), Dot(name: "51cf0", x: 660, y: 1850, connected: ["50cf0", "60r"]), Dot(name: "52cf0", x: 617, y: 1850, connected: ["51cf0", "63r"]), Dot(name: "53cf0", x: 582, y: 1850, connected: ["52cf0", "61r"]), Dot(name: "54cf0", x: 483, y: 1850, connected: ["53cf0", "66r"]), Dot(name: "55cf0", x: 463, y: 1850, connected: ["54cf0"]), Dot(name: "56cf0", x: 463, y: 1767, connected: ["55cf0"]), Dot(name: "57cf0", x: 407, y: 1767, connected: ["56cf0", "68r"]), Dot(name: "58cf0", x: 340, y: 1767, connected: ["57cf0", "68ar"]), Dot(name: "59cf0", x: 284, y: 1767, connected: ["58cf0", "69r", "69ar"]), Dot(name: "60cf0", x: 284, y: 1701, connected: ["59cf0", "70r1"]), Dot(name: "61cf0", x: 284, y: 1637, connected: ["60cf0", "71r"]), Dot(name: "62cf0", x: 284, y: 1599, connected: ["61cf0", "70r2"]), Dot(name: "63cf0", x: 284, y: 1552, connected: ["62cf0", "72r"]), Dot(name: "64cf0", x: 285, y: 1484, connected: ["63cf0", "75r", "74r"]), Dot(name: "65cf0", x: 285, y: 1418, connected: ["64cf0", "77r", "76r"]), Dot(name: "66cf0", x: 285, y: 1348, connected: ["65cf0", "stairs0floorAbylaikhan"]), Dot(name: "67cf0", x: 285, y: 1293, connected: ["66cf0", "79r"]), Dot(name: "68cf0", x: 285, y: 1263, connected: ["67cf0", "78r", "80r"]), Dot(name: "69cf0", x: 285, y: 1211, connected: ["68cf0", "elevators0floorAbylaikhan"]), Dot(name: "70cf0", x: 285, y: 1141, connected: ["69cf0", "81r"]), Dot(name: "71cf0", x: 285, y: 1073, connected: ["70cf0", "82r", "83r"]), Dot(name: "72cf0", x: 285, y: 998, connected: ["71cf0", "84r", "85r"]), Dot(name: "73cf0", x: 285, y: 819, connected: ["72cf0"]), Dot(name: "74cf0", x: 275, y: 800, connected: ["73cf0"]), Dot(name: "75cf0", x: 275, y: 678, connected: ["74cf0", "86r"]), Dot(name: "76cf0", x: 275, y: 557, connected: ["75cf0"]), Dot(name: "77cf0", x: 281, y: 545, connected: ["76cf0"]), Dot(name: "78cf0", x: 281, y: 335, connected: ["77cf0", "90r"]), Dot(name: "79cf0", x: 281, y: 308, connected: ["78cf0", "93r"]), Dot(name: "80cf0", x: 281, y: 191, connected: ["79cf0", "94r"])]
        
        rooms[0] = floor0Rooms
        rooms[2] = floor2Rooms
        rooms[4] = floor4Rooms
        rooms[5] = floor5Rooms
        
        connectors[0] = floor0Connectors
        connectors[2] = floor2Connectors
        connectors[4] = floor4Connectors
        connectors[5] = floor5Connectors
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


//https://ideone.com/UVQKqC

//https://ideone.com/V8JxTA
