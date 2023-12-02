//
//  FinishScene.swift
//  Breakout
//
//  Created by Norbert Haubner on 08.03.22.
//

import Foundation
import SpriteKit

class Finish001: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .gray
        
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.text = "Level 1 Cleared"
        label.fontColor = .white
        label.fontSize = 45
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nextLevel = Level002(size: self.size)
        
        self.view?.presentScene(nextLevel)
    }
}

class Finish002: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .gray
        
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.text = "Level 2 Cleared"
        label.fontColor = .white
        label.fontSize = 45
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)
    }
}
