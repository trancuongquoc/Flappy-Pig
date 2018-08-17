//
//  CustomImageView.swift
//  MinBar
//
//  Created by Quoc Cuong on 1/17/18.
//  Copyright © 2018 Pentor. All rights reserved.
//

import UIKit
extension UIImageView {
        @IBInspectable var cornerRadius: CGFloat {
            set {
                self.tag = Int(newValue)
                layer.cornerRadius = self.tag == -1 ? (frame.width / 2) : CGFloat(self.tag)
                clipsToBounds = true
            }
            get {
                return CGFloat(self.tag)
        }
    }
}
