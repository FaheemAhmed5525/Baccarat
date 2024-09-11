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
   
    @State var bettingAmount : Int = 20
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
                            DiscardPile(width: width/8, height: height/4)
                
                            VStack {
                                //coins box
                                ChipStackView(width: width/2, height: height/8)
                                
                                //Betting Amount Label
                                Text("Betting Amount: \(bettingAmount)")
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
                                    if bettingAmount >= 5 {
                                        bettingAmount -= 5
                                    }
                                }
                                Button("-20$") {
                                    if bettingAmount >= 20 {
                                        bettingAmount -= 20
                                    }
                                }
                                Button("-100$") {
                                    if bettingAmount >= 100 {
                                        bettingAmount -= 100
                                    }
                                }
                                Button("-1000$") {
                                    if bettingAmount >= 1000 {
                                        bettingAmount -= 1000
                                    }
                                }
                            }
                            .padding(20)
                        }
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
                .padding(.trailing, 24)
        } else {
            Image("back")
                .resizable()
                .frame(width: width, height: height)
                .cornerRadius(8)
                .padding(.trailing, 24)
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
        Image("back")
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
