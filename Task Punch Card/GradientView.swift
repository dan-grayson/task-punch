//
//  GradientView.swift
//  Task Punch Card
//
//  Created by Daniel Grayson on 2/23/16.
//  Copyright © 2016 Daniel Grayson. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.whiteColor()
    @IBInspectable var secondColor: UIColor = UIColor.blackColor()
    
    override class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [firstColor.CGColor, secondColor.CGColor]
    }

}
