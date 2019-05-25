//
//  CreateCompanyViewController.swift
//  CoreData
//
//  Created by We//Yes on 25/05/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class CreateCompanyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .tealColor;
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap));
        self.view.addGestureRecognizer(tap);
        
        navigationItem.title = "Create Company";
        let leftTitle = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleTap));
        leftTitle.tintColor = .white;
        
        navigationItem.leftBarButtonItem = leftTitle;
        // Do any additional setup after loading the view.
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
         self.dismiss(animated: true);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }`
    */

}
