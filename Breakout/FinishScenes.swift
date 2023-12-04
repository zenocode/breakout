//
//  FinishScene.swift
//  Breakout
//
//  Created by Norbert Haubner on 08.03.22.
//

import Foundation
import SpriteKit
import SwiftUI

// Used to display a level finsh and on tap go the next level
class LvlFinishScene: SKScene {
    let lvlFinished: Int
    let gameState: GameState

    init(lvlFinished: Int, gameState: GameState) {
        self.lvlFinished = lvlFinished
        self.gameState = gameState
        super.init(size: UIScreen.main.bounds.size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        backgroundColor = .gray

        let label = SKLabelNode(fontNamed: "Helvetica")
        label.text = "Level \(lvlFinished + 1) Cleared"
        label.fontColor = .white
        label.fontSize = 45
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let game = GameScene(gameState: gameState)
        self.view?.presentScene(game)
    }
}

// Used to display game finish when all level have been completed
class GameFinishScene: SKScene {
    let gameState: GameState

    init(gameState: GameState) {
        self.gameState = gameState
        super.init(size: UIScreen.main.bounds.size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        backgroundColor = .gray

        let label = SKLabelNode(fontNamed: "Helvetica")
        label.text = "You Won!"
        label.fontColor = .white
        label.fontSize = 45
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
