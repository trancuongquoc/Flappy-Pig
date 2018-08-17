//
//  Pipe.swift
//  test
//
//  Created by quoccuong on 8/16/18.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit

class Pipe {
    var x: CGFloat = 400
    var y: CGFloat = 0
    var width: CGFloat = 100
    var height: CGFloat = 200
    static var limit: CGFloat = 600

    init(origin: CGPoint, size: CGSize) {
        let origin = origin
        let size = size
        self.x = origin.x
        self.y = origin.y
        self.width = size.width
        self.height = size.height
    }

    class func getRandomHeight(view: UIView) -> CGFloat {
        let pipeHeight = CGFloat.random(min: 75, max: view.bounds.height / 2)
        return pipeHeight
    }
    
    class func create(pipeDimension: Pipe, view: UIView) -> UIView {
        let pipeView = UIView(frame: CGRect(x: pipeDimension.x, y: pipeDimension.y, width: pipeDimension.width, height: pipeDimension.height))
        pipeView.layer.contents = UIImage(named: "pipe-red")?.cgImage
        view.addSubview(pipeView)
        return pipeView
    }
    
    class func move(pipe: UIView, delay: Double) {
        UIView.animate(withDuration: 2, delay: delay, options: [.curveLinear], animations: {
            pipe.frame.origin.x -= limit
        },
                       completion: nil
        )
    }
    
//    class func spawn(_ view: UIView, delay: Double, baseground_height: CGFloat) {
//        let verticalDistance: CGFloat = 200
//        let upperPipe_dim = Pipe(origin: CGPoint(x: 400, y: 0), size: CGSize(width: 100, height: CGFloat.random(min: 75, max: view.bounds.height / 2)))
//
//        let lowerPipe_height = view.bounds.height - upperPipe_dim.height - verticalDistance - baseground_height
//        let lowerPipe_y      = upperPipe_dim.height + verticalDistance
//        let lowerPipe_dim = Pipe(origin: CGPoint(x: 400, y: lowerPipe_y), size: CGSize(width: 100, height: lowerPipe_height))
//
//        let upperPipe = Pipe.create(pipeDimension: upperPipe_dim, view: view)
//        let lowerPipe = Pipe.create(pipeDimension: lowerPipe_dim, view: view)
//
//        Pipe.move(pipe: lowerPipe, delay: delay)
//        Pipe.move(pipe: upperPipe, delay: delay)
//    }

    
}
