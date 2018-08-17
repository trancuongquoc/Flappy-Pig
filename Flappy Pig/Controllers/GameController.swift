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
    var timer: Timer?

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
    

    @objc func startGame() {
        welcomeContainerView.isHidden = true
        tappingButton.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1 / 30, target: self, selector: #selector(run), userInfo: nil, repeats: true)
        spawningPipes()
    }
    
    var randomHeight: CGFloat = Pipe.getRandomHeight()

    @objc func run() {
        movingBaseground()
        animate()
        accelerate()
    }
}

extension GameController {
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
extension GameController { // Pipe spawning logic
    func spawningPipes() {
        let upperPipeDim = Pipe(origin: CGPoint(x: 400, y: 0), size: CGSize(width: 100, height: randomHeight))
        let upperPipe = Pipe.create(pipeDimension: upperPipeDim, view: view)
        
        let lowerPipe_y   = upperPipeDim.height + verticalDistance
        let lowerPipe_height = view.bounds.height - lowerPipe_y - basegroundImageView.bounds.height
        let lowerPipe_dim = Pipe(origin: CGPoint(x: 400, y: lowerPipe_y), size: CGSize(width: 100, height: lowerPipe_height))
        let lowerPipe = Pipe.create(pipeDimension: lowerPipe_dim, view: view)
        Pipe.move(pipe: upperPipe, delay: 0)
        Pipe.move(pipe: lowerPipe, delay: 0)
    }
    
    func spawnNextPipes(delay: Double) {
        randomHeight = Pipe.getRandomHeight()
        let upperPipeDim = Pipe(origin: CGPoint(x: 400, y: 0), size: CGSize(width: 100, height: randomHeight))
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
    }
    func setupBackground() {
        Background.setImage(backgroundImage: backgroundImageView)
    }
    
    func movingBaseground() {
        Baseground.move(leadingConstraint: basegroundLeadingConstraint)
    }
}

extension GameController { //Bird Acceleration and animation
    @objc func jumpUp(_ sender: Any) {
        GamePlay.jump(time: &t, velocity: &velocity)
    }
    
    func accelerate() {
        GamePlay.accelerate(time: &t, velocity: &velocity, bottomConstraint: &birdBottomConstraint.constant)
    }
    
    func animate() {
        Bird.animate(flappyPigImageView)
    }
}
