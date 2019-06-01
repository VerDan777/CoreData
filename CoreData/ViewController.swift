//
//  ViewController.swift
//  CoreData
//
//  Created by We//Yes on 25/05/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit
import CoreData

class Image {
    var image: Data?
    
    init(image: Data? = nil) {
        guard let imageData = image else { return };
        self.image = imageData;
    }
}

class CompaniesViewController: UITableViewController, CreateCompanyDelegate {
    func didAddCompany(company: Company) {
        self.addCompany(company: company);
    }
    
    var companies = [Company]();
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBaseStyle();
        
        self.setupNavigationButtons();
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        tableView.backgroundColor = UIColor(red: 9/255, green: 46/255, blue: 64/255, alpha: 1)
        tableView.tableFooterView = UIView();
        tableView.separatorColor = .white;
        
        self.fetchCompanies();
    }
    
    private func fetchCompanies() {
        
        let ctx = CoreDataManager.shared.persistentContainer.viewContext;
        let fetchRequest = NSFetchRequest<CompanyModel>(entityName: "CompanyModel");
        do {
            let res = try ctx.fetch(fetchRequest);
            
            // litlle tricky hack
            var tempCompanies = [Company]();
            
            if res.count == 0 { return }
            
            res.forEach { (item) in
                let compEntity = Company(name: item.name!, founded: item.founded!, image: item.image);
                tempCompanies.append(compEntity);
            }
            
            self.companies = tempCompanies;
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData();
            }
        } catch let err {
            print(err);
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel();
        label.text = "No companies available...";
        label.textColor = .white;
        label.textAlignment = .center;
        label.font = UIFont.boldSystemFont(ofSize: 16);
        
        return label;
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.companies.count > 0 ? 0 : 150;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companies.count;
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            
            self.companies.remove(at: indexPath.row);
            
            let ctx = CoreDataManager.shared.persistentContainer.viewContext;
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CompanyModel");
            
            do {
                let test = try ctx.fetch(fetchRequest);
                
                let sourceElement = test[indexPath.row] as! NSManagedObject;
                
                ctx.delete(sourceElement);
                
                self.tableView.reloadData();
                
                do {
                    try ctx.save();
                } catch let error {
                    print(error);
                }
                
            } catch let err {
                print(err);
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData();
            }
        }
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView();
        header.backgroundColor = .lightBlue;
        return header;
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        
        let dateFormatter = DateFormatter();
    
        dateFormatter.dateFormat = "dd/MM/yyyy";
        
        let finalDate = dateFormatter.string(from: self.companies[indexPath.row].founded);
        
        cell.backgroundColor = UIColor.tealColor;
        cell.textLabel?.text = "\(self.companies[indexPath.row].name) - Founded: \(finalDate)";
        cell.textLabel?.textColor = .white;
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16);
        cell.imageView?.layer.cornerRadius = 5;
        cell.imageView?.clipsToBounds = true;
        
        if let pic = self.companies[indexPath.row].image {
            cell.imageView?.image = UIImage(data: pic);
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "app_icon");
        }
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        
        let companyVC = CreateCompanyViewController();
        companyVC.delegate = self;
        
        if let pic = self.companies[indexPath.row].image {
            cell.imageView?.image = UIImage(data: pic);
            companyVC.imageData = pic;
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "app_icon");
        }
        
        let companyEVC = EmployeesController();
        companyEVC.company = self.companies[indexPath.row];
//        companyEVC.company = self.companies[indexPath.row];
        
        navigationController?.pushViewController(companyEVC, animated: true);
//        self.present(UINavigationController(rootViewController:companyVC), animated: true, completion: nil);
    }
    
    private func setupNavigationButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handlePressRightButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handlePressLeftButton));
    }
    
    @objc private func handlePressLeftButton() {
        let ctx = CoreDataManager.shared.persistentContainer.viewContext;
        
        let batchRequest = NSBatchDeleteRequest(fetchRequest: CompanyModel.fetchRequest());
        
        do {
            try ctx.execute(batchRequest);
            try ctx.save();
            
            var indexPaths = [IndexPath]();
            
            for (index, _) in self.companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0);
                indexPaths.append(indexPath);
            }
            
            self.companies.removeAll();
            
            self.tableView.deleteRows(at:indexPaths, with: .middle);
    
        } catch let error {
            print(error)
        }
    }
    
    @objc private func handlePressRightButton() {
    
        let createCompaniesController = CreateCompanyViewController();
        
        createCompaniesController.delegate = self;
        
        let ctx = CoreDataManager.shared.persistentContainer.viewContext;
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CompanyModel");
        
        do {
            let result = try ctx.fetch(request);
            
        } catch let error {
            print(error.localizedDescription);
        }
        
        self.present(UINavigationController(rootViewController: createCompaniesController), animated: true);
    }
    
    func addCompany(company: Company) {
        
        self.companies.append(company);
        
        let newIndex = IndexPath(row: self.companies.count - 1, section: 0);
        
        tableView.beginUpdates();
        
        tableView.insertRows(at: [newIndex] , with: .automatic);
        
        tableView.endUpdates();
        
    }
    
    private func setupBaseStyle() {
        
        view.backgroundColor = .white;
        navigationItem.title = "Companies";

        navigationController?.navigationBar.isTranslucent = false;
        navigationController?.navigationBar.barTintColor = UIColor.lightBackround;
        navigationController?.navigationBar.prefersLargeTitles = true;
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ];
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white]
    }

}

