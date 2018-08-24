//
//  GamePlay.swift
//  Flappy Pig
//
//  Created by quoccuong on 8/16/18.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit
import CoreGraphics

class GamePlay {
    
    static var gravity : CGFloat = 9.8
    static var v0: CGFloat = 10

    static func jump(time: inout CGFloat, velocity: inout CGFloat) {
        time = 0
        velocity = v0
    }
    
    static func accelerate(time : inout CGFloat, velocity: inout CGFloat, bottomConstraint constant: inout CGFloat) {
        time += 0.01
        velocity = velocity - (gravity * time)
        constant += velocity
    }
    
    static func isCollided(firstView: UIImageView, secondView: UIImageView) -> Bool {
        let collided = firstView.frame.intersects(secondView.frame)
        return collided
        }
    }

