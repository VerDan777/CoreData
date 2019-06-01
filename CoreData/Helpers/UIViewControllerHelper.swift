//
//  UIViewControllerHelper.swift
//  CoreDataApp
//
//  Created by We//Yes on 01/06/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func setupLightBlueView(height: CGFloat = 150, color: UIColor?) -> UIView {

        let whiteView = UIView();
        
        whiteView.backgroundColor = color ?? .red;

        whiteView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view.addSubview(whiteView);

        whiteView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        whiteView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        whiteView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        whiteView.heightAnchor.constraint(equalToConstant: height).isActive = true;
        
        return whiteView;
    }

}
