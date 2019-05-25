//
//  ViewController.swift
//  CoreData
//
//  Created by We//Yes on 25/05/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit

class CompaniesViewController: UITableViewController {
    
    let companies = [
        Company(name: "Apple", founded: Date()),
        Company(name: "Microsoft", founded: Date()),
        Company(name: "Facebook", founded: Date())
    ];
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupBaseStyle();
        
        self.setupNavigationButtons();
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        tableView.backgroundColor = UIColor(red: 9/255, green: 46/255, blue: 64/255, alpha: 1)
        tableView.tableFooterView = UIView();
        tableView.separatorColor = .white;
//        tableView.separatorStyle = .none;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companies.count;
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
        
        cell.backgroundColor = UIColor.tealColor;
        cell.textLabel?.text = self.companies[indexPath.row].name;
        cell.textLabel?.textColor = .white;
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16);
        
        return cell;
    }
    
    private func setupNavigationButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handlePressRightButton))
    }
    
    @objc private func handlePressRightButton() {
        print("32131");
        
        self.present(UINavigationController(rootViewController: CreateCompanyViewController()), animated: true);
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

