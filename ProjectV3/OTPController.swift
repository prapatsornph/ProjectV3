//
//  OTPController.swift
//  ProjectV3
//
//  Created by Prapatsorn on 2/3/2561 BE.
//  Copyright © 2561 Prapatsorn. All rights reserved.
//

import UIKit
import Foundation

class OTPController: UIViewController {
    
    let confirmOTPButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 42, g: 94, b: 190)
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //button.addTarget(self, action: #selector(handleComfirmPayment), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let fillOTPTextFeild: UITextField = {
        let textFeild = UITextField()
        textFeild.text = "Please fill OTP from your email."
        textFeild.translatesAutoresizingMaskIntoConstraints = false
        return textFeild
    }()
    let OTPTextFeild: UITextField = {
        let textFeild = UITextField()
        textFeild.placeholder = "OTP"
        textFeild.translatesAutoresizingMaskIntoConstraints = false
        return textFeild
    }()
    let OTPSeperatorFeild: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let resendOTPButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Resend OTP", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        //button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        view.addSubview(fillOTPTextFeild)
        view.addSubview(confirmOTPButton)
        view.addSubview(OTPTextFeild)
        view.addSubview(OTPSeperatorFeild)
        view.addSubview(resendOTPButton)
        setupNavBar()
        setupConfirmOTPButton()
        setupfillOTPTextFeild()
        setupOTPTextFeild()
        setupResendOTPButton()
    }
    
    func setupNavBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 100))
        navBar.barTintColor = UIColor(r: 89, g: 148, b: 205)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let navItem = UINavigationItem(title: "Payment")
        //let backButton = UIBarButtonItem(title: "Cancle", style: .plain, target: self, action: #selector(handleForgotPass))
        //let backButton = UIBarButtonItem(image : UIImage(named: "icon.png"), style: .plain, target: self, action: #selector(handleForgotPass))
        //navItem.leftBarButtonItem = backButton
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    func setupfillOTPTextFeild() {
        fillOTPTextFeild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        fillOTPTextFeild.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        fillOTPTextFeild.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        fillOTPTextFeild.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    func setupOTPTextFeild() {
        OTPTextFeild.topAnchor.constraint(equalTo: fillOTPTextFeild.bottomAnchor, constant: 30).isActive = true
        OTPTextFeild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        OTPTextFeild.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        OTPTextFeild.heightAnchor.constraint(equalToConstant: 37.5).isActive = true
        
        OTPSeperatorFeild.topAnchor.constraint(equalTo: OTPTextFeild.bottomAnchor, constant: 5).isActive = true
        OTPSeperatorFeild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14).isActive = true
        OTPSeperatorFeild.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14).isActive = true
        OTPSeperatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    func setupResendOTPButton(){
        resendOTPButton.topAnchor.constraint(equalTo: OTPSeperatorFeild.bottomAnchor, constant: 20).isActive = true
        resendOTPButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resendOTPButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        resendOTPButton.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    func setupConfirmOTPButton() {
        confirmOTPButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmOTPButton.topAnchor.constraint(equalTo: resendOTPButton.bottomAnchor, constant: 30).isActive = true
        confirmOTPButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        confirmOTPButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
