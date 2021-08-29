//
//  ImageView.swift
//  shoppy
//
//  Created by YasirRomaya on 8/29/21.
//

import Foundation
import UIKit

extension UIImageView {
    func addGradientFadingLayerEffect() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [
            UIColor.white.withAlphaComponent(1).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.endPoint =  CGPoint(x: 0, y: 0.5)
        self.layer.mask = gradientLayer
    }
}
