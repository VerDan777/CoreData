//
//  CreateEmployeeController.swift
//  CoreDataApp
//
//  Created by We//Yes on 01/06/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class CreateEmployeeController: UIViewController {
    
    let tf: UITextField = {
        let textfield = UITextField();
        textfield.placeholder = "Text";
//        textfield.backgroundColor = UIColor.white;
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.leftViewMode = UITextField.ViewMode.always;
        textfield.translatesAutoresizingMaskIntoConstraints = false;
        return textfield;
    }();
    
    let nameLb: UILabel = {
        let nameLabel = UILabel();
        nameLabel.text = "Name";
//        nameLabel.backgroundColor = UIColor;
        nameLabel.translatesAutoresizingMaskIntoConstraints = false;
        return nameLabel;
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.tealColor;
        
        navigationItem.title = "Create Employee";
        
        let whiteView = setupLightBlueView(height: 50, color: .lightBlue);
        
        setupBarRightButton();
        
        whiteView.addSubview(nameLb);
        
        nameLb.topAnchor.constraint(equalTo: whiteView.topAnchor).isActive = true;
        nameLb.leftAnchor.constraint(equalTo: whiteView.leftAnchor, constant: 16).isActive = true;
        nameLb.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        nameLb.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        
        whiteView.addSubview(tf);
        
        tf.topAnchor.constraint(equalTo: whiteView.topAnchor).isActive = true;
        tf.leftAnchor.constraint(equalTo: nameLb.rightAnchor, constant: 8).isActive = true;
        tf.rightAnchor.constraint(equalTo: whiteView.rightAnchor).isActive = true;
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    fileprivate func setupBarRightButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc fileprivate func handleSave() {
        print("save");
        
        guard let text = tf.text else { return };
        
        let isValid = text.count > 0 && true;
        
        if isValid  {
            CoreDataManager.shared.createEmployeee(name: text, comletition: { (err) in
                if err == nil {
                    print("Good...");
                    self.dismiss(animated: true);
                    UIView.animate(withDuration: 0.5, animations: {
                        self.navigationController?.popViewController(animated: true);
                    })
                }
            });
        }
    }

}
