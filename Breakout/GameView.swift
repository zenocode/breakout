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
                SpriteView(scene: game)
                .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .ignoresSafeArea()
                    .statusBar(hidden: true)
                if gameState.isGameOver || gameState.isGameWon {
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
