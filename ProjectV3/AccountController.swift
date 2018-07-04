//
//  AccountController.swift
//  Shop
//
//  Created by Benz on 21/4/2561 BE.
//  Copyright © 2561 Benz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

class AccountController: UICollectionViewController {
    
    let logoutbutton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 42, g: 94, b: 190)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = UIColor.white
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Account"
        titleLabel.textColor = UIColor.rgb(red: 28, green: 49, blue: 75)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.titleView = titleLabel
        
        view.addSubview(logoutbutton)

    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            //GIDSignIn.sharedInstance().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }

}
