//
//  ViewController.swift
//  Flappy Pig
//
//  Created by quoccuong on 8/13/18.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var basegroundImageView: UIImageView!
    @IBOutlet weak var basegroundLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var flappyPigImageView: UIImageView!
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        flappyPigImageView.image  = UIImage(named: "bluebird-midflap")
        backgroundImageView.image = UIImage(named: "background-1")
        basegroundImageView.image = UIImage(named: "base")
        var basegroundTimer = Timer.scheduledTimer(timeInterval: 1.0 / 30, target: self, selector: #selector(movingBaseground), userInfo: nil, repeats: true)
        var flyingAnimationTimer = Timer.scheduledTimer(timeInterval: 1.0 / 70, target: self, selector: #selector(birdFlyingAnimation), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func movingBaseground() {
        if basegroundLeadingConstraint.constant <= -80 {
            basegroundLeadingConstraint.constant = -10
        }
        basegroundLeadingConstraint.constant -= 5
    }
}

extension ViewController {
    @objc func birdFlyingAnimation() {
        if counter > 30 {
            counter = 1
        }
        counter += 1
        if counter == 10 || counter == 20 || counter == 30 {
            flappyPigImageView.image = UIImage(named: "yellowbird-\(counter)")
        }
    }
}
