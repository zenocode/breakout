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
    var game: GameScene {
        let scene = GameScene(gameState: gameState)
        let screenSize = UIScreen.main.bounds
        scene.size = CGSize(width: screenSize.width, height: screenSize.height)
        scene.scaleMode = .aspectFit
        return scene
    }

    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }

    var body: some View {
        NavigationStack(path: $gameState.navigationPath) {
            ZStack {
//                Image not in assets
//                Image("menu_bg")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(minWidth: 0, maxHeight: .infinity)
//                    .ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    NavigationLink(destination: GameView(gameState: gameState, game: game), label: {
                            Text("Start Game")
                                .foregroundColor(Color.white)
                        })
                    Spacer()
                }
            }
//                .frame(width: 440, height: 950, alignment: .center)
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
