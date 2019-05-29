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
        nameLabel.backgroundColor = UIColor.white;
//        nameLabel.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0));
        nameLabel.translatesAutoresizingMaskIntoConstraints = false;
        return nameLabel;
    }();
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"));
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        return imageView;
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
    
    let datePicker: UIDatePicker = {
        let dt = UIDatePicker();
        dt.translatesAutoresizingMaskIntoConstraints = false;
        dt.datePickerMode = .date;
        return dt;
    }();
    
    let whiteView: UIView = {
        let vw = UIView();
        vw.backgroundColor = .white;
        vw.translatesAutoresizingMaskIntoConstraints = false;
        return vw;
    }();


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(whiteView);
        view.backgroundColor = .tealColor;
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap));
        self.view.addGestureRecognizer(tap);
        
        self.whiteView.addSubview(tf);
        self.whiteView.addSubview(nameLb);
        
        navigationItem.title = "Create Company";
        
        self.whiteView.addSubview(companyImageView);
        
        whiteView.topAnchor.constraint(equalTo: self.nameLb.bottomAnchor).isActive = true;
        whiteView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        whiteView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        whiteView.heightAnchor.constraint(equalToConstant: 350).isActive = true;
        
        companyImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        companyImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true;
        companyImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        companyImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        
        nameLb.topAnchor.constraint(equalTo: self.companyImageView.bottomAnchor).isActive = true;
        nameLb.leftAnchor.constraint(equalTo: self.whiteView.leftAnchor).isActive = true;
        nameLb.heightAnchor.constraint(equalTo: tf.heightAnchor).isActive = true;
        nameLb.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        
        tf.topAnchor.constraint(equalTo: self.companyImageView.bottomAnchor).isActive = true;
        tf.leftAnchor.constraint(equalTo: self.nameLb.rightAnchor).isActive = true;
        tf.rightAnchor.constraint(equalTo: self.whiteView.rightAnchor).isActive = true;
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.whiteView.addSubview(datePicker);
        
        
        datePicker.topAnchor.constraint(equalTo: self.whiteView.topAnchor).isActive = true;
        datePicker.leftAnchor.constraint(equalTo: self.whiteView.leftAnchor).isActive = true;
        datePicker.rightAnchor.constraint(equalTo: self.whiteView.rightAnchor).isActive = true;
        datePicker.centerYAnchor.constraint(equalTo: self.whiteView.centerYAnchor).isActive = true;
        
        
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
    }
    
    @objc private func handleSave() {
        
        let context =  CoreDataManager.shared.persistentContainer.viewContext;
        
        let companyEntity = NSEntityDescription.insertNewObject(forEntityName: "CompanyModel", into: context);
        
        companyEntity.setValue(datePicker.date, forKey: "founded");
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
