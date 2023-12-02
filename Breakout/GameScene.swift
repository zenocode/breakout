//
//  GameScene.swift
//  Breakout
//
//  Created by Norbert Haubner on 27.02.22.
//

import Foundation
import SpriteKit
import GameKit

class GameScene: SKScene, ObservableObject, SKPhysicsContactDelegate {
    
    let paddle = SKSpriteNode(imageNamed: "paddle")
    let ball = SKSpriteNode(imageNamed: "ball")
    
    var brickCounter = 0
    
    @Published var score = 0
    
    @Published var isGameOver = false
    
    enum bitmasks: UInt32 {
        case frame = 0b1        // 1
        case paddle = 0b10      // 2
        case brick = 0b100      // 4
        case ball = 0b1000      // 8
    }
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .darkGray
        view.showsPhysics = true
        
        scene?.size = view.bounds.size
        scene?.scaleMode = .aspectFill
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        self.isPaused = true
        
        // Paddle
        paddle.position = CGPoint(x: size.width / 2, y: 75)
        paddle.zPosition = 2
        paddle.physicsBody = SKPhysicsBody(texture: paddle.texture!, size: paddle.texture!.size())
        paddle.physicsBody?.friction = 0
        paddle.physicsBody?.allowsRotation = false
        paddle.physicsBody?.restitution = 1
        paddle.physicsBody?.isDynamic = false
        paddle.physicsBody?.categoryBitMask = bitmasks.paddle.rawValue
        paddle.physicsBody?.contactTestBitMask = bitmasks.ball.rawValue
        paddle.physicsBody?.collisionBitMask = bitmasks.ball.rawValue
        addChild(paddle)
        
        // Ball
        ball.position.x = paddle.position.x
        ball.position.y = paddle.position.y + ball.size.height
        ball.zPosition = 2
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.height / 2)
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.categoryBitMask = bitmasks.ball.rawValue
        ball.physicsBody?.contactTestBitMask = bitmasks.paddle.rawValue | bitmasks.frame.rawValue | bitmasks.brick.rawValue
        ball.physicsBody?.collisionBitMask = bitmasks.paddle.rawValue | bitmasks.frame.rawValue | bitmasks.brick.rawValue
        addChild(ball)
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 3))
        
        // Frame
        let frame = SKPhysicsBody(edgeLoopFrom: self.frame)
        frame.friction = 0
        frame.categoryBitMask = bitmasks.frame.rawValue
        frame.contactTestBitMask = bitmasks.ball.rawValue
        frame.collisionBitMask = bitmasks.ball.rawValue
        self.physicsBody = frame
        
        // Bricks (Maximum per Row is 15 Bricks)
        makeBricks(row: 15, bitmask: 0b100, y: 800, name: "bluebrick")
        makeBricks(row: 15, bitmask: 0b100, y: 787, name: "redbrick")
        makeBricks(row: 15, bitmask: 0b100, y: 774, name: "bluebrick")
        makeBricks(row: 15, bitmask: 0b100, y: 761, name: "redbrick")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            paddle.position.x = location.x
            
            if isPaused == true {
                ball.position.x = location.x
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isPaused = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isPaused = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        if paddle.position.x < 50 {
            paddle.position.x = 50
        }
        
        if paddle.position.x > self.size.width - paddle.size.width / 2 {
            paddle.position.x = self.size.width - paddle.size.width / 2
        }
    }
    
//    func gameOver() {
//        let gameOverLabel = SKLabelNode()
//        gameOverLabel.text = "GameOver"
//        gameOverLabel.zPosition = 3
//        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
//
//        isGameOver = true
//
//        ball.removeFromParent()
//        paddle.removeFromParent()
//    }
    
    func makeBricks(row: Int, bitmask: UInt32, y: Int, name: String) {
        let maxRow = 15
        let padding = (maxRow - row) / 2
        for i in 1...row {
            let brick = SKSpriteNode(imageNamed: name)
            brick.position = CGPoint(x: 7 + (i + padding) * Int(brick.size.width + 1), y: y)
            brick.zPosition = 2
            brick.name = "Brick" + String(i)
            brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size )
            brick.physicsBody?.friction = 0
            brick.physicsBody?.allowsRotation = false
            brick.physicsBody?.restitution = 1
            brick.physicsBody?.isDynamic = false
            brick.physicsBody?.categoryBitMask = bitmasks.brick.rawValue
            brick.physicsBody?.contactTestBitMask = bitmasks.ball.rawValue
            brick.physicsBody?.collisionBitMask = bitmasks.ball.rawValue
            addChild(brick)
        }
    }
    
    func addScore() {
        score += 1
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA: SKPhysicsBody
        let contactB: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            contactA = contact.bodyA
            contactB = contact.bodyB // Ball
        } else {
            contactA = contact.bodyB
            contactB = contact.bodyA // Ball
        }
        
        if contactA.categoryBitMask == bitmasks.brick.rawValue && contactB.categoryBitMask == bitmasks.ball.rawValue {
            
            contactA.node?.removeFromParent() // contactA = Brick
            brickCounter += 1
            addScore()
            
            if brickCounter == 60 { // Normal 60
                finishLevel()
            }
        }
        
        if contactA.categoryBitMask == bitmasks.paddle.rawValue && contactB.categoryBitMask == bitmasks.ball.rawValue {
            
            if contactB.node!.position.x <= contactA.node!.frame.midX - 5 {
                contactB.node?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                contactB.node?.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 3))
            }
            
            if contactB.node!.position.x <= contactA.node!.frame.midX + 5 {
                contactB.node?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                contactB.node?.physicsBody?.applyImpulse(CGVector(dx: -3, dy: 3))
            }
        }
        
        if contactA.categoryBitMask == bitmasks.frame.rawValue && contactB.categoryBitMask == bitmasks.ball.rawValue {
            
            let yPos = contact.contactPoint.y
            if yPos <= self.frame.minY + 10 {
                gameOver()
            }
        }
    }
    
    func gameOver() {
        let gameOverLabel = SKLabelNode()
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.text = "GameOver"
        gameOverLabel.fontSize = 35
        gameOverLabel.zPosition = 3
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height / 1.5)
        addChild(gameOverLabel)
        
        isGameOver = true
        
        ball.removeFromParent()
        paddle.removeFromParent()
    }
    
    func finishLevel() {
        
        let finishScene = Finish001(size: self.size)
        
        self.view?.presentScene(finishScene)
    }
}
