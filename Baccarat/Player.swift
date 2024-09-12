//
//  Player.swift
//  Baccarat
//
//  Created by Faheeam Ahmed on 11/09/2024.
//

import Foundation
import SwiftUI

struct Player {
    @State var playerNum: Int
    @State var betOnTie: Int = 0
    @State var betOnBanker: Int = 0
    @State var betOnPlayer: Int = 0
    
    
}

class Players {
    static var players: Array<Player> = [Player(playerNum: 1), Player(playerNum: 2), Player(playerNum: 3), Player(playerNum: 4)]
    
    static var selectedPlayerIndex: Int = 10                      //Index is change to a player's stack when he taps a stack
    static var selectedStack: betStacks = betStacks.noStack  //no stack is selected by default
}

enum betStacks {
    case tie
    case banker
    case player
    case noStack
}
