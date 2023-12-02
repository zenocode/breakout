//
//  GameOverScene.swift
//  Breakout
//
//  Created by Norbert Haubner on 18.03.22.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .gray
        
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.text = "Game Over"
        label.fontColor = .white
        label.fontSize = 45
        label.position = CGPoint(x: size.width / 2, y: size.height / 1.8)
        addChild(label)
        
        let label2 = SKLabelNode(fontNamed: "Helvetica")
        label2.text = "Tap to Restart"
        label2.fontColor = .white
        label2.fontSize = 25
        label2.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label2)
    }
}
