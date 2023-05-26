//
//  database.swift
//  diplomaProject
//
//  Created by Имангали on 3/16/23.
//

import Foundation

class Room {
    var id: String
    var x: Double
    var y: Double
    init(_ y: Double, _ x: Double, _ id: String) {
        self.id = id
        self.x = x
        self.y = y
    }
}

let rooms: [Room] = [
    Room(112, 38, "room1"),
    Room(116, 40, "id1"),
    Room(126, 40, "id2"),
    Room(135, 40, "id3"),
    Room(135, 31, "id4"),
    Room(131, 31, "room4"),
    Room(126, 42, "room3"),
    Room(149, 40, "id5"),
    Room(149, 26, "id6"),
    Room(149, 19, "taukeIn"),
    Room(16, 19, "id7"),
    Room(16, 107, "aitekeIn"),
    Room(48, 107, "id8"),
    Room(48, 130, "id9"),
    Room(48, 139, "id10"),
    Room(48, 149, "id11"),
    Room(50, 152, "room9"),
    Room(47, 143, "room7"),
    Room(50, 142, "room8"),
    Room(47, 134, "room5"),
    Room(50, 134, "room6"),
    Room(149, 62, "id12"),
    Room(133, 62, "floorTauke"),
    Room(113, 42, "room2")
]

let edges = [
    "room1": ["id1"],
    "room2": ["id1"],
    "id1": ["id2", "room1", "room2"],
    "id2": ["room3", "id1"],
    "room3": ["id2"]
]
