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
                .frame(width: .infinity,height: .infinity)
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
                            
                            
                            let x = geometry.frame(in: .global).origin.x
                            let y = geometry.frame(in: .global).origin.y
                            
                            // DiscardPile
                            DiscardPile(width: width/8, height: height/4)
                
                            
                            //coins box
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.yellow)
                                .frame(width: width/2, height: height/8)
                                .padding(.top, 0.0)
                            
                            // DiscardPile
                            RoundedRectangle(cornerRadius: 8.0)
                                .stroke(Color.black)
                                .frame(width: width/5, height: height/4)
                                .padding(.leading, 24)
                        }
                            .padding(24)
                        
                        HStack {
                                                    
                            
                            let x = geometry.frame(in: .global).origin.x
                            let y = geometry.frame(in: .global).origin.y
                            
                            ZStack {
                                // PlayerHand 1
                                RoundedRectangle(cornerRadius: 8.0)
                                    .stroke(Color.black)
                                    .frame(width: width/5, height: height/4)

                            }
                            .padding(.trailing, 24)
                            
                            ZStack {
                                // BankerHand 4
                                RoundedRectangle(cornerRadius: 8.0)
                                    .stroke(Color.black)
                                    .frame(width: width/5, height: height/4)
                                

                            }
                            .padding(.leading, 24)
                            
                        }
                        Spacer(minLength: 00)
                    }
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
