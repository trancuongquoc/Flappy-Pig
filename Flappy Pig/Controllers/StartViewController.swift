//
//  StartViewController.swift
//  Flappy Pig
//
//  Created by quoccuong on 8/14/18.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit


class StartViewController: UIViewController {
    
    @IBOutlet weak var welcomeButton: UIButton!
    var gameController: GameController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startAcceleration(_ sender: UIButton) {
        NotificationCenter.default.post(name: .start, object: nil)
    }

}

extension Notification.Name {
    static let start = Notification.Name("start")
}
