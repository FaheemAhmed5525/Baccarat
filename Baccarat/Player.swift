//
//  Player.swift
//  Baccarat
//
//  Created by Faheeam Ahmed on 11/09/2024.
//

import Foundation
import SwiftUI

struct Player {
    var playerNum: Int
    var betOnTie: Int = 0
    var betOnBanker: Int = 0
    var betOnPlayer: Int = 0
    
    
}

enum stackTapOption {
    case selected
    case saved
}

enum betStacks {
    case tie
    case banker
    case player
    case noStack
}


