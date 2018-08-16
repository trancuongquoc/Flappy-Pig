//
//  Bird.swift
//  Flappy Pig
//
//  Created by quoccuong on 8/16/18.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit

class Bird {
    
    static var counter = 0
    
    class func animate(_ birdImageView: UIImageView) {
        if counter > 30 {
            counter = 1
        }
        counter += 1
        if counter == 10 || counter == 20 || counter == 30 {
            birdImageView.image = UIImage(named: "yellowbird-\(counter)")
        }
    }
}
