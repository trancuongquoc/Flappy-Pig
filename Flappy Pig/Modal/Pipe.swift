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
    static var const: CGFloat = 10

    init(origin: CGPoint, size: CGSize) {
        let origin = origin
        let size = size
        self.x = origin.x
        self.y = origin.y
        self.width = size.width
        self.height = size.height
    }
    
    static func create(x: CGFloat, y:CGFloat, width: CGFloat, height: CGFloat, view: UIView) -> UIView {
        let pipeView = UIView(frame: CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height)))
        pipeView.layer.contents = UIImage(named: "pipe-red")?.cgImage
        view.addSubview(pipeView)
        return pipeView
    }
    
    static func move(pipe: inout UIView, view: UIView) {
        pipe.frame.origin.x -= const
    }
    
    static var random_height = CGFloat.random(min: 75, max: 400)
    
    static func settingPointAndSize(upper_pipe: inout UIView, lower_pipe: inout UIView, view: UIView) {
        random_height = CGFloat.random(min: 75, max: 400)
        
        let vertical_gap: CGFloat = 300
        let lower_pipe_y = random_height + vertical_gap
        let lower_pipe_height = view.bounds.height - lower_pipe_y - 120
        
        let upper_pipe_dimension = Pipe(origin: CGPoint(x: 400, y: 0), size: CGSize(width: 90, height: random_height))
        let lower_pipe_dimension = Pipe(origin: CGPoint(x: 400, y: lower_pipe_y), size: CGSize(width: 90, height: lower_pipe_height))
        
        upper_pipe = create(x: upper_pipe_dimension.x, y: upper_pipe_dimension.y, width: upper_pipe_dimension.width, height: upper_pipe_dimension.height, view: view)
        lower_pipe = create(x: lower_pipe_dimension.x, y: lower_pipe_dimension.y, width: lower_pipe_dimension.width, height: lower_pipe_dimension.height, view: view)
    }
}
