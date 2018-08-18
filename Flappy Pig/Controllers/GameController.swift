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
        let pipe_width: CGFloat = 90
        let pipe_height: CGFloat = 300
        var start_point: CGFloat = 500
        upperPipe_1st = Pipe.create(x: start_point, y: 0, width: pipe_width, height: pipe_height, view: view)
        upperPipe_2nd = Pipe.create(x: start_point + 300, y: 0, width: pipe_width, height: pipe_height, view: view)
        upperPipe_3rd = Pipe.create(x: start_point + 600, y: 0, width: pipe_width, height: pipe_height, view: view)
        
        let vertical_gap: CGFloat = 200
        let lowerPipe_y = pipe_height + vertical_gap
        let lowerPipe_height = view.bounds.height - lowerPipe_y - basegroundImageView.bounds.height
        
        lowerPipe_1st = Pipe.create(x: start_point, y: lowerPipe_y, width: pipe_width, height: lowerPipe_height, view: view)
        lowerPipe_2nd = Pipe.create(x: start_point + 300, y: lowerPipe_y, width: pipe_width, height: lowerPipe_height, view: view)
        lowerPipe_3rd = Pipe.create(x: start_point + 600, y: lowerPipe_y, width: pipe_width, height: lowerPipe_height, view: view)

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
    }
    
    var upperPipe_1st: UIView?
    var upperPipe_2nd: UIView?
    var upperPipe_3rd: UIView?
    
    var lowerPipe_1st: UIView?
    var lowerPipe_2nd: UIView?
    var lowerPipe_3rd: UIView?
    
    @objc func run() {
        movingBaseground()
        animate()
        accelerate()
        spawningPipes()
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
        let outscreen_point: CGFloat = -600
        Pipe.move(pipe: &upperPipe_1st!, view: view)
        Pipe.move(pipe: &upperPipe_2nd!, view: view)
        Pipe.move(pipe: &upperPipe_3rd!, view: view)
        Pipe.move(pipe: &lowerPipe_1st!, view: view)
        Pipe.move(pipe: &lowerPipe_2nd!, view: view)
        Pipe.move(pipe: &lowerPipe_3rd!, view: view)
        
        if (upperPipe_1st?.frame.origin.x)! <= outscreen_point {
            Pipe.settingPointAndSize(upper_pipe: &upperPipe_1st!, lower_pipe: &lowerPipe_1st!, view: view)
        }
        if (upperPipe_2nd?.frame.origin.x)! <= outscreen_point {
            Pipe.settingPointAndSize(upper_pipe: &upperPipe_2nd!, lower_pipe: &lowerPipe_2nd!, view: view)
        }
        if (upperPipe_3rd?.frame.origin.x)! <= outscreen_point {
            Pipe.settingPointAndSize(upper_pipe: &upperPipe_3rd!, lower_pipe: &lowerPipe_3rd!, view: view)
        }
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
