//
//  Extensions.swift
//  CoreData
//
//  Created by We//Yes on 25/05/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let tealColor = UIColor(red: 48/255, green: 164/255, blue: 182/255, alpha: 1);
    
    static let lightColor = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1);
    
    static let lightBackround = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1);
    
    static let lightBlue = UIColor(red: 218/255, green: 235/255, blue: 243/255, alpha: 1)
}

extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
}
