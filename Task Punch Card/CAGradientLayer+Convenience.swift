//
//  CAGradientLayer+Convenience.swift
//  Task Punch Card
//
//  Created by Daniel Grayson on 2/23/16.
//  Copyright © 2016 Daniel Grayson. All rights reserved.
//

import UIKit

extension CAGradientLayer {

    func getLayer(topColor: UIColor, bottomColor: UIColor) -> CAGradientLayer {
        //let topColor = UIColor(red: 1.0, green: 0.3, blue: 0.0, alpha: 1.0)
        //let bottomColor = UIColor(red: 1.0, green: 0.8, blue: 0.4, alpha: 1.0)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        return gradientLayer
    }
    
    func getWarmLayer() -> CAGradientLayer {
        let topColor = UIColor(red: 1.0, green: 0.3, blue: 0.0, alpha: 1.0)
        let bottomColor = UIColor(red: 1.0, green: 0.8, blue: 0.4, alpha: 1.0)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        return gradientLayer
    }

}
