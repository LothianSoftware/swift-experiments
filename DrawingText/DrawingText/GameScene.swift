//
//  GameScene.swift
//  DrawingText
//
//  Created by Thibault Imbert on 2014-06-17.
//  Copyright (c) 2014 Thibault Imbert. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {

        // we pick the font we want to use
        let font = UIFont(name: "Arial", size: 18)
        
        // our string, note that we use here NSString instead of String that has more APIs like drawInRect and size
        // it is preferred to use Swift native rypes like String but for now String has a limited API surface
        let text: NSString = "Copyright © - Thibault Imbert"
        
        // we reference our image (path)
        var data = NSData (contentsOfFile: "/Users/timbert/Documents/Ayden.jpg")
        
        // we create a UIImage out of it
        var image = UIImage(data: data)
        
        // our rectangle for the drawing size
        let rect = CGRectMake(0, 0, image.size.width, image.size.height)
        
        // we create our graphics context at the size of our image
        UIGraphicsBeginImageContextWithOptions(CGSize(width: image.size.width, height: image.size.height), true, 1)
        
        // we retrieve it
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, CGColorCreateGenericRGB(1, 1, 1, 1))
        
        // we draw our inage to the graphics context
        image.drawInRect(rect)
        
        // the size of our text
        let size = text.sizeWithFont(font)
        // the rect for the drawing position of our copyright text message
        let rectText = CGRectMake(image.size.width-size.width, image.size.height-(size.height+4), image.size.width-(size.width+4), image.size.height)
        
        // we draw the text on the graphics context, with our font
        text.drawInRect(rectText, withFont: font)
        
        // we grab a UIImage from the graphics context
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
       // we remove our bitmap from the stack
        UIGraphicsEndImageContext();
        
        // we create a texture, pass the UIImage
        var texture = SKTexture(image: newImage)
        
        // wrap it inside a sprite node
        var sprite = SKSpriteNode(texture:texture)
        
        // we scale it a bit
        sprite.setScale(0.5);
        
        // we position it
        sprite.position = CGPoint (x: 510, y: 300)
        
        // let's display it
        self.addChild(sprite)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
