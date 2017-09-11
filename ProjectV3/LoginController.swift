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
import Foundation
import MessageUI

class LoginController: UIViewController {
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 42, g: 94, b: 190)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
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
        textField.placeholder = "Password"
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
    let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var loginRegisterSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Sign In", "Sign Up"])
        segmentControl.tintColor = UIColor.white
        segmentControl.selectedSegmentIndex = 0
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
        view.addSubview(forgotPasswordButton)
        
        //UINavigationController = self
        
        setupLoginRegisterSegmentControl()
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupForgotPasswordButton()
    }
    //function handle
    func handleForgotPassword() {
        let forgotPassController = ForgotPasswordController()
        present(forgotPassController, animated: true, completion: nil)
    }
    
    var inputsContrainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    var confirmPassTextFieldHeightAnchor: NSLayoutConstraint?
    func handleLoginRegisterChange() {
        let title = loginRegisterSegmentControl.titleForSegment(at: loginRegisterSegmentControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        inputsContrainerViewHeightAnchor?.constant = loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 75 : 150
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor? = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 0 : 1/4)
        nameTextFieldHeightAnchor?.isActive = true
        nameTextField.isHidden = loginRegisterSegmentControl.selectedSegmentIndex == 0
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor? = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 1/2 : 1/4)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor? = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 1/2 : 1/4)
        passwordTextFieldHeightAnchor?.isActive = true
        
        confirmPassTextFieldHeightAnchor?.isActive = false
        confirmPassTextFieldHeightAnchor? = confirmPassTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 0 : 1/4)
        confirmPassTextFieldHeightAnchor?.isActive = true
        confirmPassTextField.isHidden = loginRegisterSegmentControl.selectedSegmentIndex == 0
        
        forgotPasswordButton.isHidden = loginRegisterSegmentControl.selectedSegmentIndex == 1
    }
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmPassTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        let isEmailValid = isValidEmailAddress(emailAddressString: email)
        let isPasswordValid = isValidPassword(password : password)
        if isEmailValid && isPasswordValid {
            print("Email address or Password is valid")
            if password == confirm {
                Auth.auth().createUser(withEmail: email, password: password, completion: {(user: User?, error) in
                    if let err = error {
                        print(err)
                        return
                    }
                Auth.auth().currentUser?.sendEmailVerification { (error) in
                    self.showAlertButtonTapped(sender: UIButton.init(), message: "Please verify your email before sign in.", check: false)
                    
                }
                if error == nil {
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
                        
                        //self.present(self, animated: true, completion: nil)
                        //self.dismiss(animated: true, completion: nil)
                    })
                }
            })
            }
        } else {
            self.showAlertButtonTapped(sender: UIButton.init(), message: "Your email or password is invalid.\nYour password must have:\n-8 or more than characters\n-At least one number and special character", check: false)
        }
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        let isEmailValid = isValidEmailAddress(emailAddressString: email)
        let isPasswordValid = isValidPassword(password : password)
        if isEmailValid && isPasswordValid {
            print("Email address or Password is valid")
            Auth.auth().signIn(withEmail: email, password: password, completion: {(user: User?, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                Auth.auth().currentUser?.reload(completion: { (error) in
                    if error == nil {
                        if (Auth.auth().currentUser?.isEmailVerified)! {
                            print("Login Successful")
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            do {
                                try Auth.auth().signOut()
                            } catch let logoutError {
                                print(logoutError)
                            }
                            self.showAlertButtonTapped(sender: UIButton.init(), message: "Your email is not verify.", check: false)
                        }
                    } else {
                        print(error?.localizedDescription)
                    }
                })
            })
        } else {
            self.showAlertButtonTapped(sender: UIButton.init(), message: "Your email or password is incorrect.", check: false)
        }
    }
    
    
    func handleLoginRegister() {
        if loginRegisterSegmentControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    //function set up
    func setupInputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContrainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 75)
            inputsContrainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorFeild)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorFeild)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(passwordSeparatorFeild)
        inputsContainerView.addSubview(confirmPassTextField)
        inputsContainerView.addSubview(confirmPassSeparatorFeild)
        
        //nameTextField
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
            nameTextFieldHeightAnchor?.isActive = true
        nameTextField.isHidden = loginRegisterSegmentControl.selectedSegmentIndex == 0
        nameSeparatorFeild.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorFeild.topAnchor.constraint(equalTo: nameTextField.topAnchor).isActive = true
        nameSeparatorFeild.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //emailTextField
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            emailTextFieldHeightAnchor?.isActive = true
        emailSeparatorFeild.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorFeild.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailSeparatorFeild.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //passwordTextField
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            passwordTextFieldHeightAnchor?.isActive = true
        passwordSeparatorFeild.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        passwordSeparatorFeild.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordSeparatorFeild.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //confirmPassTextField
        confirmPassTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        confirmPassTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        confirmPassTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        confirmPassTextFieldHeightAnchor = confirmPassTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
            confirmPassTextFieldHeightAnchor?.isActive = true
        confirmPassTextField.isHidden = loginRegisterSegmentControl.selectedSegmentIndex == 0
        confirmPassSeparatorFeild.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        confirmPassSeparatorFeild.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        confirmPassSeparatorFeild.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        confirmPassSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
        

    }
    
    func setupLoginRegisterSegmentControl() {
        loginRegisterSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 0.80).isActive = true
        loginRegisterSegmentControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    func setupLoginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 13).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupForgotPasswordButton() {
        forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        forgotPasswordButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 55).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    //function validation
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
    
    func isValidPassword(password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func showAlertButtonTapped(sender: UIButton, message: String, check: Bool) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: check ? {
                action in self.dismiss(animated: true, completion: nil)
            } : nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func otpGenerator() -> String {
        let randomValue = Int(arc4random_uniform(10000))
        let stringRandom = "\(randomValue)"
        return stringRandom
    }
    
    /*func sendEmailVerification() {
        let email = emailTextField.text
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
        // Configure the fields of the interface.
        composeVC.setToRecipients([email!])
        composeVC.setSubject("Verify your email address!")
        composeVC.setMessageBody("This email sent by ProjectV3.\nIt's looks like this is the first time. We need to verify this email. You may be asked to enter this security code: " + otpGenerator(), isHTML: false)
    }*/
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}


