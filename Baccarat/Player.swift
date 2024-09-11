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
    @State var bedOnTie: Int = 0
    @State var bedOnBanker: Int = 0
    @State var bedOnPlayer: Int = 0
}
