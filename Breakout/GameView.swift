//
//  GameView.swift
//  Breakout
//
//  Created by Norbert Haubner on 01.03.22.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    @StateObject private var game = GameScene()
    @StateObject private var lv2 = Level002()
    
    var body: some View {
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
            
            if game.isGameOver {
                NavigationLink(destination: ContentView(), label: {
                    Text("Main Menu")
                })
            }
            VStack(alignment: .trailing) {
                            Text("Score: \(game.score)")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                            .foregroundColor(.white)
            }
        }
        .ignoresSafeArea()
    }
}
