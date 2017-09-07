//
//  ForgotPasswordController.swift
//  ProjectV3
//
//  Created by Prapatsorn on 9/4/2560 BE.
//  Copyright © 2560 Prapatsorn. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordController: UIViewController {
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    let emailForForgotPassTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 42, g: 94, b: 190)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleResetPassButton), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 106, g: 148, b: 199)
        view.addSubview(inputsContainerView)
        view.addSubview(emailForForgotPassTextField)
        view.addSubview(continueButton)
        setupInputsContainerView()
        setupContinueButton()
        handleForgotPass()
        setupNavBar()
    }
    
    func setupNavBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 60))
        navBar.backgroundColor = UIColor(r: 42, g: 94, b: 190)
        let navItem = UINavigationItem(title: "Reset Password")
        let backButton = UIBarButtonItem(title: "<Back", style: .plain, target: self, action: #selector(handleForgotPass))
        //let backButton = UIBarButtonItem(image : UIImage(named: "icon.png"), style: .plain, target: self, action: #selector(handleForgotPass))
        navItem.leftBarButtonItem = backButton
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    func setupInputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 37.5).isActive = true
        
        inputsContainerView.addSubview(emailForForgotPassTextField)
        
        emailForForgotPassTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailForForgotPassTextField.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor).isActive = true
        emailForForgotPassTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailForForgotPassTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    func setupContinueButton() {
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 13).isActive = true
        continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func handleForgotPass() {
        /*let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)*/
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleResetPassButton() {
        guard let email = emailForForgotPassTextField.text else {
            print("Form is not valid")
            return
        }
        let isEmailValid = isValidEmailAddress(emailAddressString: email)
        if isEmailValid {
            print("Email address or Password is valid")
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                self.showAlertButtonTapped(sender: UIButton.init(), message: "Please check your email.", check: true)
            }
        } else {
            self.showAlertButtonTapped(sender: UIButton.init(), message: "Your email is invalid.", check: false)
        }
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    func showAlertButtonTapped(sender: UIButton, message: String, check: Bool) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: check ? {
                action in self.dismiss(animated: true, completion: nil)
            } : nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
