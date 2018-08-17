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
    let verticalDistance: CGFloat = 200
    var v0 : CGFloat = 10
    var gravity : CGFloat = 9.8
    var velocity: CGFloat = 0
    var t: CGFloat = 0
    
    var isCollided: Bool = false {
        didSet {
            if isCollided == true {
                t = 0
                velocity = 0
                welcomeContainerView.isHidden = false
                stopTimer()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(startGame), name: .start, object: nil)
        setupGameOpponents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupGameOpponents() {
        t = 0
        setupBaseground()
        setupBackground()
        setupTappingButton()
    }
    
    func setupTappingButton() {
        tappingButton.isHidden = true
        tappingButton.frame = view.bounds
        tappingButton.addTarget(self, action: #selector(jumpUp(_:)), for: .touchUpInside)
        view.addSubview(tappingButton)
    }
    
    var animationTimer: Timer?
    var accelerationTimer: Timer?
    var spawningPipeTimer: Timer?
    var basegroundTimer: Timer?
    @objc func startGame() {
        welcomeContainerView.isHidden = true
        tappingButton.isHidden = false
        animationTimer = Timer.scheduledTimer(timeInterval: 1.0 / 70, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
        accelerationTimer = Timer.scheduledTimer(timeInterval: 1.0 / 30, target: self, selector: #selector(accelerate), userInfo: nil, repeats: true)
        spawningPipeTimer = Timer.scheduledTimer(timeInterval: 2.1, target: self, selector: #selector(spawningPipes), userInfo: nil, repeats: true)
    }
    
 
}

extension GameController {
    func stopTimer() {
        animationTimer?.invalidate()
        accelerationTimer?.invalidate()
        spawningPipeTimer?.invalidate()
        basegroundTimer?.invalidate()
    }
}
extension GameController { // Pipe spawning logic
    @objc func spawningPipes() {
        let upperPipeDim = Pipe(origin: CGPoint(x: 400, y: 0), size: CGSize(width: 100, height: Pipe.getRandomHeight(view: view)))
        let upperPipe = Pipe.create(pipeDimension: upperPipeDim, view: view)
        
        let lowerPipe_y   = upperPipeDim.height + verticalDistance
        let lowerPipe_height = view.bounds.height - lowerPipe_y - basegroundImageView.bounds.height
        let lowerPipe_dim = Pipe(origin: CGPoint(x: 400, y: lowerPipe_y), size: CGSize(width: 100, height: lowerPipe_height))
        let lowerPipe = Pipe.create(pipeDimension: lowerPipe_dim, view: view)
        Pipe.move(pipe: upperPipe, delay: 0)
        Pipe.move(pipe: lowerPipe, delay: 0)
        spawnNextPipes(delay: 1.0)
    }
    
    func spawnNextPipes(delay: Double) {
        let upperPipeDim = Pipe(origin: CGPoint(x: 400, y: 0), size: CGSize(width: 100, height: Pipe.getRandomHeight(view: view)))
        let upperPipe = Pipe.create(pipeDimension: upperPipeDim, view: view)
        
        let lowerPipe_y   = upperPipeDim.height + verticalDistance
        let lowerPipe_height = view.bounds.height - lowerPipe_y - basegroundImageView.bounds.height
        let lowerPipe_dim = Pipe(origin: CGPoint(x: 400, y: lowerPipe_y), size: CGSize(width: 100, height: lowerPipe_height))
        let lowerPipe = Pipe.create(pipeDimension: lowerPipe_dim, view: view)
        
        Pipe.move(pipe: upperPipe, delay: delay)
        Pipe.move(pipe: lowerPipe, delay: delay)
    }
}
extension GameController { //Baseground and background setup
    
    func setupBaseground() {
        Baseground.setImage(basegroundImage: basegroundImageView)
        basegroundTimer = Timer.scheduledTimer(timeInterval: 1.0 / 30, target: self, selector: #selector(movingBaseground), userInfo: nil, repeats: true)
    }
    func setupBackground() {
        Background.setImage(backgroundImage: backgroundImageView)
    }
    
    @objc func movingBaseground() {
        Baseground.move(leadingConstraint: basegroundLeadingConstraint)
    }
}

extension GameController { //Bird Acceleration and animation
    @objc func jumpUp(_ sender: Any) {
        GamePlay.jump(time: &t, velocity: &velocity)
    }
    
    @objc func accelerate() {
        GamePlay.accelerate(time: &t, velocity: &velocity, bottomConstraint: &birdBottomConstraint.constant)
    }
    
    @objc func animate() {
        Bird.animate(flappyPigImageView)
    }
}
