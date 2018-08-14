//
//  ViewController.swift
//  Flappy Pig
//
//  Created by quoccuong on 8/13/18.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var welcomeContainerView: UIView!
    @IBOutlet weak var birdBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var basegroundImageView: UIImageView!
    @IBOutlet weak var basegroundLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var flappyPigImageView: UIImageView!
    let tappingButton : UIButton = UIButton()
    var counter = 0
    var v0 : CGFloat = 10
    var gravity : CGFloat = 9.8
    var velocity: CGFloat = 0
    var t: CGFloat = 0
    var startTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(startGame), name: .start, object: nil)
        setupTappingButton()
        setupBackground()
        basegroundImageView.image = UIImage(named: "base")
        t = 0
        let basegroundTimer = Timer.scheduledTimer(timeInterval: 1.0 / 30, target: self, selector: #selector(movingBaseground), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupTappingButton() {
        tappingButton.isHidden = true
        tappingButton.frame = view.bounds
        tappingButton.addTarget(self, action: #selector(jumpUp(_:)), for: .touchUpInside)
        view.addSubview(tappingButton)
    }

    @objc func startGame() {
        welcomeContainerView.isHidden = true
        tappingButton.isHidden = false
        let flyingAnimationTimer = Timer.scheduledTimer(timeInterval: 1.0 / 70, target: self, selector: #selector(birdFlyingAnimation), userInfo: nil, repeats: true)
        let startGameTimer = Timer.scheduledTimer(timeInterval: 1.0 / 30, target: self, selector: #selector(birdAcceleration), userInfo: nil, repeats: true)
    }
}

extension GameController { //Baseground and background setup
    
    func setupBackground() {
        backgroundImageView.image = UIImage(named: "background-1")
    }
    
    @objc func movingBaseground() {
        if basegroundLeadingConstraint.constant <= -80 {
            basegroundLeadingConstraint.constant = -10
        }
        basegroundLeadingConstraint.constant -= 5
    }
}

extension GameController { //Bird Acceleration and animation
    @objc func jumpUp(_ sender: Any) {
        t = 0
        velocity = v0
    }
    
    @objc func birdAcceleration() {
        t += 0.01
        velocity = velocity - (gravity * t)
        birdBottomConstraint.constant += velocity
    }
    
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
