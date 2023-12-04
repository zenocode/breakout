//
//  GameView.swift
//  Breakout
//
//  Created by Norbert Haubner on 01.03.22.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    //    @StateObject private var game = GameScene(gameState: gameState)
    //    @StateObject private var lv2 = Level002()
    @State var gameState: GameState
    @StateObject var game: GameScene

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                HStack {
                    SpriteView(scene: game)
                    //SpriteView(scene: game, debugOptions: [.showsPhysics])
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
                    Text("Score: \(game.score)")
                        .padding(.top, 60)
                        .foregroundColor(.white)
                }
            }
                .frame(width: geo.size.width, alignment: .center)
                .ignoresSafeArea()
        }
    }
}
