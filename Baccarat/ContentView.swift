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
    
    @State var bettingAmount: Int = 0
    
    @State var card: [Int: Bool] = Dictionary(uniqueKeysWithValues: (1...52).map {($0, false) })   //array for check used and unused card
    
    /// These var will be used for calculation of  resulat and also to show card on screen in Player's and Banker's hand
    @State var playerHandCard1 = 0
    @State var playerHandCard2 = 0
    @State var playerHandCard3 = 0
    
    @State var bankerHandCard1 = 0
    @State var bankerHandCard2 = 0
    @State var bankerHandCard3 = 0
    
    
    
    @State var players: Array<Player> = [Player(playerNum: 1), Player(playerNum: 2), Player(playerNum: 3), Player(playerNum: 4)]
    
    
    
    var body: some View {
                
        ZStack {
            //Backgrond
            GeometryReader{ geometry in
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(UIColor.systemGray2))
            }

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
                                
                                Button("Start") {
                                    print("drawing cards")
                                    var randomNum: Int
                                    
                                    randomNum = Int.random(in: 1...52)
                                    
                                    //get a unused card
                                    while card[randomNum] == true {
                                        print("Finding free card. Randome number\(randomNum)")
                                        randomNum = Int.random(in: 1...52)
                                    }
                                    print("Found free card. Randome number\(randomNum)")
                                    //place first card on player hand
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        playerHandCard1 = randomNum
                                    }
                                    
                                    card[randomNum] = true
                                    
                                    
                                    
                                    //get a unused card
                                    while card[randomNum] == true {
                                        print("Finding free card. Randome number\(randomNum)")
                                        randomNum = Int.random(in: 1...52)
                                    }
                                    print("Found free card. Randome number\(randomNum)")
                                    //place first card on banker hand
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        bankerHandCard1 = randomNum
                                    }
                                    card[randomNum] = true
                                    
                                    
                                    //get a unused card
                                    while card[randomNum] == true {
                                        print("Finding free card. Randome number\(randomNum)")
                                        randomNum = Int.random(in: 1...52)
                                    }
                                    print("Found free card. Randome number\(randomNum)")
                                    //place second card on player hand
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        playerHandCard2 = randomNum
                                    }
                                    card[randomNum] = true
                                    
                                    
                                    
                                    //get a unused card
                                    while card[randomNum] == true {
                                        print("Finding free card. Randome number\(randomNum)")
                                        randomNum = Int.random(in: 1...52)
                                    }
                                    print("Found free card. Randome number\(randomNum)")
                                    //place second card on banker hand
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        playerHandCard1 = randomNum
                                    }
                                    card[randomNum] = true
                                    
                                    print("Player Card 1: \(playerHandCard1)")
                                    print("Player Card 2: \(playerHandCard2)")
                                    print("Player Card 3: \(playerHandCard3)")
                                    print("Banker Card 1: \(bankerHandCard1)")
                                    print("Banker Card 2: \(bankerHandCard2)")
                                    print("Banker Card 3: \(bankerHandCard3)")
                                }
                                .padding(.bottom, 0)
                                .background(Color.cyan)
                                
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
                                .overlay(
                                    
                                    HStack(alignment: .center, spacing: -width/10) {
                                        Image("Card\(playerHandCard1)")
                                             .resizable()
                                             .frame(width: width/10, height: height/4)
                                             .cornerRadius(8)
                                             .padding(.leading, 24)
                                         Image("Card\(playerHandCard2)")
                                              .resizable()
                                              .frame(width: width/10, height: height/4)
                                              .cornerRadius(8)
                                              .padding(.leading, 24)
                                         Image("Card\(playerHandCard3)")
                                              .resizable()
                                              .frame(width: width/10, height: height/4)
                                              .cornerRadius(8)
                                              .padding(.leading, 24)
                                    }
                                )
                            
                                // BankerHand
                            BankerHandView(width: width/5, height: height/4)
                                .overlay (
                                    HStack(alignment: .center, spacing: -width/10) {
                                        Image("Card\(bankerHandCard1)")
                                             .resizable()
                                             .frame(width: width/10, height: height/4)
                                             .cornerRadius(8)
                                             .padding(.leading, 24)
                                         Image("Card\(bankerHandCard2)")
                                              .resizable()
                                              .frame(width: width/10, height: height/4)
                                              .cornerRadius(8)
                                              .padding(.leading, 24)
                                         Image("Card\(bankerHandCard3)")
                                              .resizable()
                                              .frame(width: width/10, height: height/4)
                                              .cornerRadius(8)
                                              .padding(.leading, 24)
                                    }
                                )
                            
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
    
    
    
    /// Action to taked when a stack is tapped by user
    /// - Parameters:
    ///   - playerIndex: index of the player who tapped his betting area
    ///   - bettingStack: the stack which tapped, (tie, banker, or player)
    func stackTapped(playerIndex: Int, bettingStack: betStacks) {
       
        // Checking if any already selected betStack is open
        if selectedPlayerIndex < players.count {
            
            //checking if the selected Player is same as the tapped
            /// To be updated
            if selectedPlayerIndex == playerIndex-1 {
                
                //checkingif the selected stack is same as tapped
                if selectedStack == bettingStack {
                    
                    //Saving the betting amount for closing bet stack
                    if bettingStack == betStacks.tie {
                        players[selectedPlayerIndex].betOnTie = bettingAmount
                        
                    } else if bettingStack == betStacks.banker {
                        players[selectedPlayerIndex].betOnBanker = bettingAmount
                        
                    } else if bettingStack == betStacks.player {
                        players[selectedPlayerIndex].betOnPlayer = bettingAmount
                        
                    } else {
                        //No Cas
                    }
                    
                    
                    //clearing the betting amount values
                    bettingAmount = 0
                    selectedPlayerIndex = 10
                    selectedStack = betStacks.noStack
                    return
                }
                
                // another closed stack of same player is taped
                else {
                    
                    //Saving the betting amount for closing bet stack
                    if bettingStack == betStacks.tie {
                        bettingAmount = players[selectedPlayerIndex].betOnTie
                        
                    } else if bettingStack == betStacks.banker {
                        bettingAmount = players[selectedPlayerIndex].betOnBanker
                        
                    } else if bettingStack == betStacks.player {
                        bettingAmount = players[selectedPlayerIndex].betOnPlayer
                        
                    }
                    
                    
                    
                }

                
            }
            
            // another closed stack is taped
            else {
                
                //Saving the betting amount for closing bet stack
                if bettingStack == betStacks.tie {
                    players[selectedPlayerIndex].betOnTie = bettingAmount
                    
                } else if bettingStack == betStacks.banker {
                    players[selectedPlayerIndex].betOnBanker = bettingAmount
                    
                } else if bettingStack == betStacks.player {
                    players[selectedPlayerIndex].betOnPlayer = bettingAmount
                    
                }
                
                
                
            }
        }
        
        // settting the tapepd stack as selected
        selectedPlayerIndex = playerIndex - 1
        selectedStack = bettingStack
        
        if bettingStack == betStacks.tie {
            bettingAmount = players[selectedPlayerIndex].betOnTie
            
        } else if bettingStack == betStacks.banker {
            bettingAmount = players[selectedPlayerIndex].betOnBanker
            
        } else if bettingStack == betStacks.player {
            bettingAmount = players[selectedPlayerIndex].betOnPlayer
        }
        

    }

    
    /// Betting area for tie
    func TieAreaView(forPlayer: Int, center: CGPoint, radius: CGFloat, startAngle: Angle, endAngle: Angle) -> some View {
//
            return Path { path in
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
                
                stackTapped(playerIndex: forPlayer, bettingStack: betStacks.tie)
                
                print("Player \(forPlayer) bets on Tie")
            }
         
    }
    
    /// Betting area for banker
    func BankerAreaView(forPlayer: Int, center: CGPoint, radius: CGFloat, startAngle: Angle, endAngle: Angle) -> some View {
        //
        return Path { path in
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
            stackTapped(playerIndex: forPlayer, bettingStack: betStacks.banker)
            
            print("Player \(forPlayer) bets on Banker")
        }
    }
    
    /// Betting area for playerr
    func PlayerAreaView(forPlayer: Int, center: CGPoint, radius: CGFloat, startAngle: Angle, endAngle: Angle) -> some View {
        //
        return Path { path in
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
            
            stackTapped(playerIndex: forPlayer, bettingStack: betStacks.player)
            print("Player \(forPlayer) bets on Player")
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

//
///// Betting area for Tie
//struct TieAreaView: View {
//    let forPlayer: Int
//    let center: CGPoint
//    let radius: CGFloat
//    let startAngle: Angle
//    let endAngle: Angle
//    
//    var body: some View {
//        Path { path in
//            path.addArc(
//                center: center,
//                radius: radius,
//                startAngle: startAngle,
//                endAngle: endAngle,
//                clockwise: false
//            )
//        }
//        .strokedPath(StrokeStyle(lineCap: .round))
//        .stroke(Color(UIColor.systemGray4), lineWidth: 32)
//        
//    }
//}


//
//
///// Betting area for Banker
//struct BankerAreaView: View {
//    let forPlayer: Int
//    let center: CGPoint
//    let radius: CGFloat
//    let startAngle: Angle
//    let endAngle: Angle
//    
//    var body: some View {
//        Path { path in
//            path.addArc(
//                center: center,
//                radius: radius,
//                startAngle: startAngle,
//                endAngle: endAngle,
//                clockwise: false
//            )
//        }
//        .strokedPath(StrokeStyle(lineCap: .round))
//        .stroke(Color(UIColor.systemGray4), lineWidth: 32)
//        .onTapGesture {
//            print("Player \(forPlayer) bets on Banker")
//        }
//    }
//}
//
///// Betting area for Player
//struct PlayerAreaView: View {
//    let forPlayer: Int
//    let center: CGPoint
//    let radius: CGFloat
//    let startAngle: Angle
//    let endAngle: Angle
//    
//    var body: some View {
//        Path { path in
//            path.addArc(
//                center: center,
//                radius: radius,
//                startAngle: startAngle,
//                endAngle: endAngle,
//                clockwise: false
//            )
//            
//        }
//        .strokedPath(StrokeStyle(lineCap: .round))
//        .stroke(Color(UIColor.systemGray6), lineWidth: 32)
//        
//        
//        .onTapGesture {
//            print("Player \(forPlayer) bets on Player")
//        }
//    }
//}
