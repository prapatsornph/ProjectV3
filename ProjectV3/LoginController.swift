//
//  LoginController.swift
//  ProjectV3
//
//  Created by Prapatsorn on 8/30/2560 BE.
//  Copyright © 2560 Prapatsorn. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginController: UIViewController {
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 42, g: 94, b: 190)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let nameSeparatorFeild: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let emailSeparatorFeild: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password(more than 6 characters)"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    let passwordSeparatorFeild: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let confirmPassTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    let confirmPassSeparatorFeild: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loginRegisterSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Login", "Register"])
        segmentControl.tintColor = UIColor.white
        segmentControl.selectedSegmentIndex = 1
        segmentControl.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 106, g: 148, b: 199)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentControl)
        setupLoginRegisterSegmentControl()
        setupInputsContainerView()
        setupLoginRegisterButton()
    }
    
    func handleLoginRegisterChange() {
        let title = loginRegisterSegmentControl.titleForSegment(at: loginRegisterSegmentControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        inputsContrainerViewHeightAnchor?.constant = loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 75 : 150
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor? = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 0 : 1/4)
        nameTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor? = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 1/2 : 1/4)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor? = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 1/2 : 1/4)
        passwordTextFieldHeightAnchor?.isActive = true
        
        confirmPassTextFieldHeightAnchor?.isActive = false
        confirmPassTextFieldHeightAnchor? = confirmPassTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 1/2 : 1/4)
        confirmPassTextFieldHeightAnchor?.isActive = true
    }
    
    func setupLoginRegisterSegmentControl() {
        loginRegisterSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 0.80).isActive = true
        loginRegisterSegmentControl.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmPassTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        if password == confirm {
            Auth.auth().createUser(withEmail: email, password: password, completion: {(user: User?, error) in
                if let err = error {
                    print(err)
                    return
                }
                guard let uid = user?.uid else {
                    return
                }
                let ref = Database.database().reference(fromURL: "https://projectv3-182cb.firebaseio.com/")
                let values = ["name": name, "email": email]
                let userRef = ref.child("users").child((uid))
                userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if err != nil {
                        print(err ?? "")
                        return
                    }
                    print("Saved user successfully into Firebase Database")
                    self.dismiss(animated: true, completion: nil)
                })
            })
        }
        
    }
    
    var inputsContrainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    var confirmPassTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setupInputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContrainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
            inputsContrainerViewHeightAnchor?.isActive = true
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorFeild)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorFeild)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(passwordSeparatorFeild)
        inputsContainerView.addSubview(confirmPassTextField)
        inputsContainerView.addSubview(confirmPassSeparatorFeild)
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
            nameTextFieldHeightAnchor?.isActive = true
        nameSeparatorFeild.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorFeild.topAnchor.constraint(equalTo: nameTextField.topAnchor).isActive = true
        nameSeparatorFeild.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
            emailTextFieldHeightAnchor?.isActive = true
        emailSeparatorFeild.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorFeild.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailSeparatorFeild.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
            passwordTextFieldHeightAnchor?.isActive = true
        passwordSeparatorFeild.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        passwordSeparatorFeild.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordSeparatorFeild.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        confirmPassTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        confirmPassTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        confirmPassTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        confirmPassTextFieldHeightAnchor = confirmPassTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
            confirmPassTextFieldHeightAnchor?.isActive = true
        confirmPassSeparatorFeild.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        confirmPassSeparatorFeild.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        confirmPassSeparatorFeild.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        confirmPassSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true

    }
    
    func setupLoginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 13).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        //if confirmPassTextField.text == nil {
            Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
        //}
    }
    func handleLoginRegister() {
        if loginRegisterSegmentControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

