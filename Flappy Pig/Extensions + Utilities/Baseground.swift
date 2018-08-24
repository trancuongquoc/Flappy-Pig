//
//  Baseground.swift
//  Flappy Pig
//
//  Created by quoccuong on 8/16/18.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit
class Baseground {
    
    static func move(leadingConstraint: NSLayoutConstraint) {
        if leadingConstraint.constant <= -80 {
            leadingConstraint.constant = -10
        }
        leadingConstraint.constant -= 10
    }
    
    static func setImage(basegroundImage: UIImageView) {
        let image = UIImage(named: "base")
        basegroundImage.image = image
    }
}
