//
//  ContentView.swift
//  Baccarat
//
//  Created by Faheeam Ahmed on 10/09/2024.
//


import SwiftUI

struct ContentView: View {
    var sidesColor = UIColor(red: 58/255, green: 146/255, blue: 24/255, alpha: 1.0)
    var centeralColor = UIColor(red: 70/255, green: 180/255, blue: 24/255, alpha: 1.0)
   
    
    @State var selectedPlayerIndex: Int = 10                      //Index is change to a player's stack when he taps a stack
    @State var selectedStack: betStacks = betStacks.noStack  //no stack is selected by default
    
    @State var bettingAmount: Int = 20
    
    public var BettingAmount: Int {
        get {
            return bettingAmount
        }
        set {
            bettingAmount = newValue
        }
    }
    public func setBettingValue(bettingValue: Int) {
        self.bettingAmount = bettingValue
    }
    public func getBettingValue () -> Int {
        return self.bettingAmount
    }
    
    
    var players: Array<Player> = [Player(playerNum: 1), Player(playerNum: 2), Player(playerNum: 3), Player(playerNum: 4)]
    
    ///  change betValue
    /// - Parameters:
    ///   - playerIndex: Player number from players list.
    ///   - newBet: New bet value for stact for that player  [playerIndex]
    ///   - forStack: Stack on which player is betting,tie, banker or player
    func changeBet(playerIndex: Int, forStack: betStacks) {
            
        /// if bet on tie
        if forStack == betStacks.tie {
            players[playerIndex].betOnTie = bettingAmount
        }
        
        // else if bet on banker
        else if forStack == betStacks.banker {
            players[playerIndex].betOnBanker = bettingAmount
        }
            
        // else if bet on player {
        else if forStack == betStacks.player {
            players[playerIndex].betOnPlayer = bettingAmount
        }
        
        // else caller has passed ivalied arguments
        else {
            print("Invalid argumets for changing the bet")
        }

    }
    
    func stackTapped(playerIndex: Int, bettingStack: betStacks)->stackTapOption {
        
        if selectedPlayerIndex < players.count {
            if playerIndex == selectedPlayerIndex {
                changeBet(playerIndex: selectedPlayerIndex, forStack: bettingStack)
                return stackTapOption.saved
            }
            else {
                selectedPlayerIndex = playerIndex
                
                if bettingStack == betStacks.tie {
                    bettingAmount = players[playerIndex].betOnTie
                } else if bettingStack == betStacks.banker {
                    bettingAmount = players[playerIndex].betOnBanker
                } else {
                    bettingAmount = players[playerIndex].betOnPlayer
                }
                
                selectedStack = bettingStack
                return stackTapOption.selected
            }
        }
        else {
            selectedPlayerIndex = playerIndex
            
            if bettingStack == betStacks.tie {
                bettingAmount = players[playerIndex].betOnTie
            } else if bettingStack == betStacks.banker {
                bettingAmount = players[playerIndex].betOnBanker
            } else {
                bettingAmount = players[playerIndex].betOnPlayer
            }
            selectedStack = bettingStack
            
            return stackTapOption.selected
        }
    }
    
    
   
    
    
    var body: some View {
        
        
        ZStack {
            //Backgrond
            Rectangle()
                .frame(width: .infinity, height: .infinity)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color(UIColor.systemGray2))


            GeometryReader { geometry in
                
                //Getting width and heigh with respect to current screen
                let height = geometry.size.height
                let width = height * 15/8
    

                
                ZStack{
                    //background rectangle
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.gray)
                        .frame(width: width, height: height)
                        .padding(12)
                    VStack(alignment: .center) {
                        HStack(alignment: .top) {
                            
                            
//                            let x = geometry.frame(in: .global).origin.x
//                            let y = geometry.frame(in: .global).origin.y
                            
                            // DiscardPile
                            DiscardPile(width: width/10, height: height/4)
                
                            VStack {
                                //coins box
                                ChipStackView(width: width/2, height: height/8)
                                
                                //Betting Amount Label
                                Text("Betting Amount: \(bettingAmount)$")
                            }
                            // ShoeStack
                            ShoeStackView(width: width/5, height: height/4)
                        }
                            .padding(24)
                        
                        HStack {
                                                    
                            
//                            let x = geometry.frame(in: .global).origin.x
//                            let y = geometry.frame(in: .global).origin.y
                            
                                // PlayerHand
                            PlayerHandView(width: width/5, height: height/4)
                            
                                // BankerHand
                            BankerHandView(width: width/5, height: height/4)
                            
                        }
                        //Spacer(minLength: 00)
                        Spacer()
                        BettingAmountChangeButtons
                    }
                    
                    //let x = geometry.frame(in: .global).origin.x
                    let y = geometry.frame(in: .global).origin.y
                    let arcCenter = CGPoint(x: width/2, y: y)
                    
                    let tieArcRadius = CGFloat(height * 5/6)
                    
                    // For player 1
                    TieAreaView(forPlayer: 1, center: arcCenter, radius: tieArcRadius, startAngle: .degrees(30), endAngle: .degrees(55))
                    
                    
                    // for Payer 2
                    TieAreaView(forPlayer: 2, center: arcCenter, radius: tieArcRadius, startAngle: .degrees(60), endAngle: .degrees(85))
                    
                    
                    // For Player 3
                    TieAreaView(forPlayer: 3, center: arcCenter, radius: tieArcRadius, startAngle: .degrees(95), endAngle: .degrees(120))
                    
                    
                    // for Player 4
                    TieAreaView(forPlayer: 4, center: arcCenter, radius: tieArcRadius, startAngle: .degrees(125), endAngle: .degrees(150))
                    
                    // Banker betting area
                    let bankerArcRadius = CGFloat(height * 11/12)
                    //for Player 1
                    BankerAreaView(forPlayer: 1, center: arcCenter, radius: bankerArcRadius, startAngle: .degrees(30), endAngle: .degrees(55))
                    
                    //for Player 2
                    BankerAreaView(forPlayer: 2, center: arcCenter, radius: bankerArcRadius, startAngle: .degrees(60), endAngle: .degrees(85))
                    
                    //for Player 3
                    BankerAreaView(forPlayer: 3, center: arcCenter, radius: bankerArcRadius, startAngle: .degrees(95), endAngle: .degrees(120))
                    
                    //for Player 4
                    BankerAreaView(forPlayer: 4, center: arcCenter, radius: bankerArcRadius, startAngle: .degrees(125), endAngle: .degrees(150))
                    
                    //Player betting are
                    let playerArcRadius = CGFloat(height)
                    //for Player 1
                    PlayerAreaView(forPlayer: 1, center: arcCenter, radius: playerArcRadius, startAngle: .degrees(30), endAngle: .degrees(55))
                    
                    //for Player 2
                    PlayerAreaView(forPlayer: 2, center: arcCenter, radius: playerArcRadius, startAngle: .degrees(60), endAngle: .degrees(85))
                    
                    //for Player 3
                    PlayerAreaView(forPlayer: 3, center: arcCenter, radius: playerArcRadius, startAngle: .degrees(95), endAngle: .degrees(120))
                    
                    //for Player 4
                    PlayerAreaView(forPlayer: 4, center: arcCenter, radius: playerArcRadius, startAngle: .degrees(125), endAngle: .degrees(150))
                    
                }
                    .frame(width: width, height: height)
                    .padding(12)
   

            }
            
        }
        
    }
    
    
    
    
    
    
    
    /// button that allows player to set and change about of bet
    var BettingAmountChangeButtons: some View {
        HStack{
            
            VStack {
                Button("+5$") {
                    bettingAmount += 5
                }
                Button("+20$") {
                    bettingAmount += 20
                }
                Button("+100$") {
                    bettingAmount += 100
                }
                Button("+1000$") {
                    bettingAmount += 1000
                }
            }
            .padding(20)
            Spacer()
            
            VStack {
                Button("-5$") {
                    if bettingAmount >= 25 {
                        bettingAmount -= 5
                    }
                }
                Button("-20$") {
                    if bettingAmount >= 40 {
                        bettingAmount -= 20
                    }
                }
                Button("-100$") {
                    if bettingAmount >= 120 {
                        bettingAmount -= 100
                    }
                }
                Button("-1000$") {
                    if bettingAmount >= 1020 {
                        bettingAmount -= 1000
                    }
                }
            }
            .padding(20)
        }
    }
    
    
}





class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?)->UIInterfaceOrientationMask {
        return .landscape
    }
}

#Preview {
    ContentView()
}






/// Create a block to present discard pile
struct DiscardPile: View {
    let width: CGFloat
    let height: CGFloat
    var isEmpty = false
    var body: some View {
        
        if isEmpty {
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color.black)
                .frame(width: width, height: height)
                .padding(.trailing, 36)
        } else {
            CardBackView(width: width, height: height)
                .padding(.trailing, 36)
        }
        
    }
}



/// Chip Stack customization
struct ChipStackView: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.yellow)
            .frame(width: width, height: height)
            .padding(.top, 0.0)
    }
}


/// Shoe Stack customization
struct ShoeStackView: View {
    let width: CGFloat
    let height: CGFloat
    @State var isEmpty = false
    
    var body: some View {
        if isEmpty {
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color.black)
                .frame(width: width, height: height)
                .padding(.leading, 24)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color.black)
                    .frame(width: width, height: height)
                    .padding(.leading, 24)
                    .overlay(
                        HStack(alignment: .center, spacing: -width/2) {
                            CardBackView(width: width/2, height: height)
                            CardBackView(width: width/2, height: height)
                            CardBackView(width: width/2, height: height)
                            CardBackView(width: width/2, height: height)
                        }
                            
                    )
            }
        }
    }
}


/// Displaying Back side of the Card
struct CardBackView: View {
                    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Image("CardBack")
            .resizable()
            .frame(width: width, height: height)
            .cornerRadius(8)
            .padding(.leading, 24)
    }
}

/// Player's hand cutomization
struct PlayerHandView: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8.0)
            .stroke(Color.black)
            .frame(width: width, height: height)
            .padding(.trailing, 24)
    }
}

/// Banker's hand customization
struct BankerHandView: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8.0)
            .stroke(Color.black)
            .frame(width: width, height: height)
            .padding(.leading, 24)
    }
}


/// Betting area for tie
struct TieAreaView: View {
    let forPlayer: Int
    let center: CGPoint
    let radius: CGFloat
    let startAngle: Angle
    let endAngle: Angle
    
    var body: some View {
        Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
        }
        .strokedPath(StrokeStyle(lineCap: .round))
        .stroke(Color(UIColor.systemGray2), lineWidth: 32)
        .onTapGesture {
            ///
            
            
            print("Player \(forPlayer) bets on Tie")
        }
    }
}



/// Betting area for Banker
struct BankerAreaView: View {
    let forPlayer: Int
    let center: CGPoint
    let radius: CGFloat
    let startAngle: Angle
    let endAngle: Angle
    
    var body: some View {
        Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
        }
        .strokedPath(StrokeStyle(lineCap: .round))
        .stroke(Color(UIColor.systemGray4), lineWidth: 32)
        .onTapGesture {
            print("Player \(forPlayer) bets on Banker")
        }
    }
}

/// Betting area for Player
struct PlayerAreaView: View {
    let forPlayer: Int
    let center: CGPoint
    let radius: CGFloat
    let startAngle: Angle
    let endAngle: Angle
    
    var body: some View {
        Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
            
        }
        .strokedPath(StrokeStyle(lineCap: .round))
        .stroke(Color(UIColor.systemGray6), lineWidth: 32)
        
        
        .onTapGesture {
            print("Player \(forPlayer) bets on Player")
        }
    }
}
