//
//  UIApplication+Extension.swift
//  simpsonsviewer
//
//  Created by naga vineel golla on 5/16/21.
//

import Foundation
import UIKit

extension UIApplication {
    class func getPresentedVC() -> UIViewController? {
        let presentedVC = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        return presentedVC?.rootViewController
    }
}
