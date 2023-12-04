//
//  ContentView.swift
//  Breakout
//
//  Created by Norbert Haubner on 19.02.22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @State var gameState: GameState = GameState()
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }

    var body: some View {
        NavigationStack(path: $gameState.navigationPath) {
            ZStack {
                Image("menu_bg")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    NavigationLink(destination: GameView(gameState: gameState, game: GameScene(gameState: gameState)), label: {
                            Text("Start Game")
                                .foregroundColor(Color.white)
                        })
                    Spacer()
                }
            }
                .frame(width: 440, height: 950, alignment: .center)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
            .navigationViewStyle(StackNavigationViewStyle())
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .statusBar(hidden: true)
    }
}
