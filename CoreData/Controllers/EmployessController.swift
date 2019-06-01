//
//  EmployessController.swift
//  CoreDataApp
//
//  Created by We//Yes on 01/06/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit
import CoreData

class EmployeesController: UITableViewController {
    
    var company: Company?;
    
    var employess = [AnyObject]();
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        navigationItem.title = "Employess";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid");
        
        fetchEmployess();
        
//        self.view.backgroundColor = .red;
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleRightButton));
    }
    
    fileprivate func fetchEmployess() {
        let ctx = CoreDataManager.shared.persistentContainer.viewContext;
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee");
        
        do {
            let result = try ctx.fetch(request);
            
            result.forEach { (item) in
                print(item);
//                guard let text = (item as AnyObject).name as? String else { return };
                self.employess.append(item as AnyObject);
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData();
            }
        } catch let error {
            print(error);
        }
    }
    
    @objc func handleRightButton() {
        navigationController?.pushViewController(CreateEmployeeController(), animated: true);
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath);
        
        let employee = self.employess[indexPath.row];
        
        cell.textLabel?.text = employee.name;

        return cell;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employess.count;
    }

}
