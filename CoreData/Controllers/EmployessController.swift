//
//  EmployessController.swift
//  CoreDataApp
//
//  Created by We//Yes on 01/06/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController {
    
    var company: Company?;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        navigationItem.title = company?.name ?? "test";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = .red;
    }

}
