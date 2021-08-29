//
//  Style.swift
//  shoppy
//
//  Created by YasirRomaya on 8/28/21.
//

import Foundation
import UIKit

class Style {
    static let sharedInstance = Style()
    
    func getAccentColor() -> UIColor{
        return UIColor(named: "AccentColor")!
    }
    
    func getNavBarBackgroundColor() -> UIColor{
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    func getBackgroundColor() -> UIColor{
        if #available(iOS 13.0, *) {
            return .secondarySystemBackground
        } else {
            return UIColor(named: "DefaultBackgroundColor")!
        }
    }
    
    func getFontColor() -> UIColor{
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
    
    func getHeadlineFont() -> UIFont {
        return UIFont(name: "Almarai-ExtraBold", size: 20)!
    }
    
    func getTitleFont() -> UIFont {
        return UIFont(name: "Almarai-Bold", size: 17)!
    }
    
    func getSubtitleFont() -> UIFont {
        return UIFont(name: "Almarai-Light", size: 15)!
    }
    
    func getBodyFont() -> UIFont {
        return UIFont(name: "Almarai-Regular", size: 17)!
    }
    
    func getButtonFont() -> UIFont {
        return UIFont(name: "Almarai-Regular", size: 17)!
    }
    
    func getCornerRadius() -> CGFloat {
        return 12
    }
}
