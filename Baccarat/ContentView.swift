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
                let width = height * 7/4
    

                
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
                
                            
                            //coins box
                            ChipStackView(width: width/2, height: height/8)
                            
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
                        Spacer(minLength: 00)
                    }
                    
                    let x = geometry.frame(in: .global).origin.x
                    let y = geometry.frame(in: .global).origin.y
                    ArcShape(
                        center: CGPoint(x: x, y: width/2),
                        radius: height * 3/2,
                        startAngle: .degrees(0),
                        endAngle: .degrees(180),
                        clockwise: true
                    )
                    .stroke(Color.black, lineWidth: 12)
                    .frame(width: width, height: height)
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


// betting area customziation
struct ArcShape: Shape {
    var center: CGPoint
    var radius: CGFloat
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let startAngleInRadians = CGFloat(startAngle.radians)
        let endAndgleInRadians = CGFloat(endAngle.radians)
        
        
        // graphics context
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return path
        }
        
        context.addArc(center: center,
                       radius: radius,
                       startAngle: startAngleInRadians,
                       endAngle: endAndgleInRadians,
                       clockwise: clockwise
        )
        
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(8)
        context.strokePath()
        
        /// Add draw path
        path.addPath(Path(context.path ?? CGPath(rect: rect, transform: .none)))
        
        UIGraphicsEndImageContext()
        
        return path
    }
}
