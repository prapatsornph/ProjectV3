//
//  SearchController.swift
//  Shop
//
//  Created by Benz on 20/4/2561 BE.
//  Copyright © 2561 Benz. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController {
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
        
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 42, green: 94, blue: 190)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(payment), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Search"
        titleLabel.textColor = UIColor.rgb(red: 28, green: 49, blue: 75)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.titleView = titleLabel
        
        
        collectionView?.backgroundColor = UIColor.white
        
        view.addSubview(inputsContainerView)
        view.addSubview(searchTextField)
        view.addSubview(continueButton)
        
        
        setupInputsContainerView()
        setupContinueButton()
        
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupInputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 37.5).isActive = true
        
        inputsContainerView.addSubview(searchTextField)
        
        searchTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        searchTextField.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor).isActive = true
        searchTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        searchTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    func setupContinueButton() {
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 13).isActive = true
        continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    
    
    @objc func payment(){
        print("pay")
    }
    
    

}
