//
//  CreateCompanyViewController.swift
//  CoreData
//
//  Created by We//Yes on 25/05/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyDelegate {
    func didAddCompany(company: Company)
}

class CreateCompanyViewController: UIViewController {
    
    var delegate: CompaniesViewController?
    
    let nameLb: UILabel = {
        let nameLabel = UILabel();
        nameLabel.text = "Name";
        nameLabel.backgroundColor = .red;
        nameLabel.translatesAutoresizingMaskIntoConstraints = false;
        return nameLabel;
    }();
    
    let tf: UITextField = {
        let textfield = UITextField();
        textfield.placeholder = "Text";
        textfield.backgroundColor = UIColor.white;
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.leftViewMode = UITextField.ViewMode.always;
        textfield.translatesAutoresizingMaskIntoConstraints = false;
//        textfield.frame = CGRect(x: 0, y: 0, width: 414, height: 100);
        return textfield;
    }();


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .tealColor;
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap));
        self.view.addGestureRecognizer(tap);
        
        self.view.addSubview(tf);
        self.view.addSubview(nameLb);
        
        navigationItem.title = "Create Company";
        
        nameLb.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        nameLb.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        nameLb.heightAnchor.constraint(equalTo: tf.heightAnchor).isActive = true;
        nameLb.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        
        tf.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        tf.leftAnchor.constraint(equalTo: self.nameLb.rightAnchor).isActive = true;
        tf.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.backgroundColor = UIColor.tealColor;
        
        self.setupButtons();
        
        // Do any additional setup after loading the view.
    }
    
    
    private func setupButtons() {
        let leftTitle = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleTap));
        let rightTitle = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        leftTitle.tintColor = .white;
        rightTitle.tintColor = .white;
        
        navigationItem.leftBarButtonItem = leftTitle;
        navigationItem.rightBarButtonItem = rightTitle;
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let decoder = JSONDecoder();
        
        if let company = UserDefaults.standard.value(forKey: "company1") as? Data {
            if let companyEntity = try? decoder.decode(Company.self, from: company) {
                let dateFormatter = DateFormatter();
                dateFormatter.dateFormat = "dd/MM/yyyy";
                dateFormatter.timeStyle = .full;
                dateFormatter.dateStyle = .full;
                let newDate = dateFormatter.string(from: companyEntity.founded);
                print(companyEntity.name, newDate);
            }
            
        }

//        guard let dataDec = data else { return };
//        print(castData["name"] ?? "");
//         self.dismiss(animated: true);
    }
    
    @objc private func handleSave() {
        
        let context =  CoreDataManager.shared.persistentContainer.viewContext;
        
        let companyEntity = NSEntityDescription.insertNewObject(forEntityName: "CompanyModel", into: context);
        
        companyEntity.setValue(Date(), forKey: "founded");
        companyEntity.setValue(tf.text!, forKey: "name");
        
        
        do {
            try context.save();
        } catch let err {
            print(err);
        }
        let company = Company(name: tf.text!, founded: Date());
        
        delegate?.didAddCompany(company:company);
        
        self.dismiss(animated: true);
        
        
        
//        guard let text = tf.text else { return };
//
//        let company = Company(name: text, founded: Date());
//
//        let endcoder = JSONEncoder();
//
//        if let endcoded = try? endcoder.encode(company) {
//            UserDefaults.standard.set(endcoded, forKey: "company1")
//        }
    
        
//        UserDefaults.standard.set(company, forKey: "company1");
    }

}
