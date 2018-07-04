//
//  MenuBarController.swift
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

class MenuBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        self.delegate = self
        

        tabBar.barTintColor = UIColor.rgb(red: 106, green: 148, blue: 199)
        tabBar.unselectedItemTintColor = UIColor.white
        tabBar.tintColor = UIColor.rgb(red: 28, green: 49, blue: 75)
        
        let layout = UICollectionViewFlowLayout()
        let navigationByHome = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
        navigationByHome.title = "All Product"
        navigationByHome.tabBarItem.image = UIImage(named: "home")
        
        let layout2 = UICollectionViewFlowLayout()
        let navigationBySearch = UINavigationController(rootViewController: SearchController(collectionViewLayout: layout2))
        navigationBySearch.title = "Search"
        navigationBySearch.tabBarItem.image = UIImage(named: "search")
        
        let layout3 = UICollectionViewFlowLayout()
        let navigationByAccount = UINavigationController(rootViewController: AccountController(collectionViewLayout: layout3))
        navigationByAccount.title = "Account"
        navigationByAccount.tabBarItem.image = UIImage(named: "user")
        
        viewControllers = [navigationByHome, navigationBySearch, navigationByAccount]
        
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
