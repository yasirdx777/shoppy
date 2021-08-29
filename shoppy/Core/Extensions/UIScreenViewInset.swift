//
//  UIScreen.swift
//  shoppy
//
//  Created by YasirRomaya on 8/29/21.
//

import Foundation
import UIKit

extension UIScreen {

    func viewInset() -> CGFloat {
        guard let rootView = UIApplication.shared.keyWindow else { return 0 }
        let topInset = rootView.safeAreaInsets.top
        let bottomInset = rootView.safeAreaInsets.bottom
        return topInset + bottomInset
    }
    
    func viewTopInset() -> CGFloat {
        guard let rootView = UIApplication.shared.keyWindow else { return 0 }
        let topInset = rootView.safeAreaInsets.top
        return topInset
    }
    
    func viewBottomInset() -> CGFloat {
        guard let rootView = UIApplication.shared.keyWindow else { return 0 }
        let bottomInset = rootView.safeAreaInsets.bottom
        return bottomInset
    }

}
