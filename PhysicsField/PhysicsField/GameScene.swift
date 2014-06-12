// Think as below as your Main class, basically the Stage
// Note: The code below is for iOS, you can run it with the iOS simulator

// this imports higher level APIs like Starling
import SpriteKit

// canvas size for the positioning
let canvasWidth: UInt32 = 800
let canvasHeight: UInt32 = 800

// From the docs:
// When a physics body is inside the region of a SKFieldNode object, that field node’s categoryBitMask property is
// compared to this physics body’s fieldBitMask property by performing a logical AND operation.
// If the result is a non-zero value, then the field node’s effect is applied to the physics body.
let fieldMask : UInt32 = 1
let categoryMask: UInt32 = 1

// our main logic inside this class
// we subclass the SKScene class by using the :TheType syntax below
class GameScene: SKScene {
    
    // our field node member
    let fieldNode: SKFieldNode
    
    // the NSCoder abstract class declares the interface used by concrete subclasses (thanks 3r1d!)
    // see: http://stackoverflow.com/users/2664437/3r1d
    init(coder decoder: NSCoder!){
        // we create a magnetic field
        fieldNode = SKFieldNode.magneticField()
        // we define its body
        fieldNode.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        // we add it to the display list (tree)
        fieldNode.categoryBitMask = categoryMask
        // we initialize the superclass
        super.init(coder: decoder)
    }
    
    // this gets triggered automatically when presented to the view, put initialization logic here
    override func didMoveToView(view: SKView) {
        
        // we set the background color to black, self is the equivalent of this in Flash
        self.scene.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        // we live in a world with gravity
        self.physicsWorld.gravity = CGVectorMake(0, -1)
        // we put contraints on the top, left, right, bottom so that our balls can bounce off them
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        // we set the body defining the physics to our scene
        self.physicsBody = physicsBody
        // we add it to the display list
        self.addChild(fieldNode)
        
        // let's create 300 bouncing cubes
        for i in 1..300 {
            
            // SkShapeNode is a primitive for drawing like with the AS3 Drawing API
            // it has built in support for primitives like a circle, or a rectangle, here we pass a rectangle
            let shape = SKShapeNode(rect: CGRectMake(-10, -10, 20, 20))
            // we set the color and line style
            shape.strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            // we set the stroke width
            shape.lineWidth = 4
            // we set initial random positions
            shape.position = CGPoint (x: CGFloat(arc4random()%(canvasWidth)), y: CGFloat(arc4random()%(canvasHeight)))
            // we add each circle to the display list
            self.addChild(shape)
            // we define the physics body
            shape.physicsBody = SKPhysicsBody(circleOfRadius: shape.frame.size.width/2)
            // this defines the mass, roughness and bounciness
            shape.physicsBody.friction = 0.8
            shape.physicsBody.restitution = 0.9
            shape.physicsBody.mass = 0.5
            // we set the field mask
            shape.physicsBody.fieldBitMask = fieldMask
            // this will allow the balls to rotate when bouncing off each other
            shape.physicsBody.allowsRotation = true
        }
    }
    
    // we capture the touch move events by overriding touchesMoved method
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        // we grab the UITouch object in the current scene (self) coordinate
        let touch = event.allTouches().anyObject().locationInNode(self)
        // we apply the position of the touch to the physics field node
        self.fieldNode.position = touch
    }
    
    // magic of the physics engine, we don't have to do anything here
    override func update(currentTime: CFTimeInterval) {
    }
}