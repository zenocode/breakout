//
//  GameView.swift
//  Breakout
//
//  Created by Norbert Haubner on 01.03.22.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @State var gameState: GameState
    @StateObject var game: GameScene

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                HStack {
                    SpriteView(scene: game)
                    .ignoresSafeArea()
                }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .ignoresSafeArea()
                    .statusBar(hidden: true)
                    .onChange(of: gameState.isGameWon) { oldValue, newValue in
                    print("NAVIGATION")
                    gameState.navigationPath = NavigationPath()
                }
                if gameState.isGameOver {
                    VStack {
                        Spacer()
                        NavigationLink(destination: ContentView(), label: {
                                Text("Main Menu")
                            })
                        Spacer()
                    }
                }
                if gameState.isGameWon {
                    VStack {
                        Spacer()
                        NavigationLink(destination: ContentView(), label: {
                                Text("Main Menu")
                            })
                        Spacer()
                    }
                }
                VStack(alignment: .trailing) {
                    Text("Score: \(gameState.score)")
                        .padding(.top, 60)
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
        }
    }
}
