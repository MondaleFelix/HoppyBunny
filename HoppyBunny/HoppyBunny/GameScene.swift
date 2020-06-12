

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var hero: SKSpriteNode!
    var sinceTouch : CFTimeInterval = 0
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        // recursive node search for 'hero' (child of referenced node)
        hero = (self.childNode(withName: "//hero") as! SKSpriteNode)
        
        // allows the hero to animate when it's in the GameScene
        hero.isPaused = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        // applies vertical impluse
        hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
        
        // Apply subtle rotation
        
        hero.physicsBody?.applyAngularImpulse(1)
        sinceTouch = 0
        
    }

    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        let velocityY = hero.physicsBody?.velocity.dy ?? 0
        
        if velocityY > 400 {
            hero.physicsBody?.velocity.dy = 400
        }
        
        if sinceTouch > 0.2 {
            let impulse = -20000 * fixedDelta
            hero.physicsBody?.applyAngularImpulse(CGFloat(impulse))
        }

        /* Clamp rotation */
        hero.zRotation.clamp(v1: CGFloat(-90).degreesToRadians(), CGFloat(30).degreesToRadians())
        hero.physicsBody?.angularVelocity.clamp(v1: -1, 3)

        /* Update last touch timer */
        sinceTouch += fixedDelta
         
    }
}
