//
//  ContentView.swift
//  Breakout
//
//  Created by Norbert Haubner on 19.02.22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    init(){
            UINavigationBar.setAnimationsEnabled(false)
        }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("menu_bg")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    NavigationLink(destination: GameView(), label: {
                        Text("Start Game")
                            .foregroundColor(Color.white)
                    })
                    Spacer()
                }//VSTack
                
            }// ZStack
            .frame(width: 440, height: 950, alignment: .center)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
        }//NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .statusBar(hidden: true)
    }
}
