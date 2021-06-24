//
//  Extenstions.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 16/06/2021.
//

import Foundation
import UIKit

extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.size.height + self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
}

extension UIImageView {
    
    public func roundedImage() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
