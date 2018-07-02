//
//  PaymentController.swift
//  ProjectV3
//
//  Created by Prapatsorn on 2/3/2561 BE.
//  Copyright © 2561 Prapatsorn. All rights reserved.
//

import UIKit
import Foundation
import SwiftOTP

class PaymentController: UIViewController {
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    lazy var confirmPaymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 42, g: 94, b: 190)
        button.setTitle("Confirm to Payment", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handlePayment), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let cardNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Credit Card Number"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let cardNumberSeparatorFeild: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let nameOnCardTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name on Credit Card"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let nameOnCardSeparatorFeild: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let expiryDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Expiry Date"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let expiryDateSeparatorFeild: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let securityCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "CCV Number"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let securityCodeSeparatorFeild: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let imageView: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "CreditCards"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        view.addSubview(confirmPaymentButton)
        view.addSubview(cardNumberTextField)
        view.addSubview(cardNumberSeparatorFeild)
        view.addSubview(nameOnCardTextField)
        view.addSubview(nameOnCardSeparatorFeild)
        view.addSubview(expiryDateTextField)
        view.addSubview(expiryDateSeparatorFeild)
        view.addSubview(securityCodeTextField)
        view.addSubview(securityCodeSeparatorFeild)
        setupNavBar()
        setupInputsContainerView1()
        setupInputsContainerView2()
        setupInputsContainerView3()
        setupInputsContainerView4()
        setupConfirmPaymentButton()
    }
    
    func setupNavBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 100))
        navBar.barTintColor = UIColor(r: 89, g: 148, b: 205)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let navItem = UINavigationItem(title: "Payment")
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    func handlePayment() {
        guard let cardNumber = cardNumberTextField.text, let name = nameOnCardTextField.text, let expiry = expiryDateTextField.text, let securityCode = securityCodeTextField.text else {
            print("Form is not valid")
            return
        }
        if checkLunh(cardNumberString: cardNumber) {
            print("Card number is valid")
        } else {
            print("Card number is invalid")
            self.showAlertButtonTapped(sender: UIButton.init(), message: "Please check your card number again.", check: false)
        }
    }
    
    func checkLunh(cardNumberString: String) -> Bool {
        let length = Int(cardNumberString.count)
        if length >= 9 {
            print("Card number is valid")
        } else {
            print("Card number is invalid")
            self.showAlertButtonTapped(sender: UIButton.init(), message: "Card number is invalid.", check: false)
        }
        let checkDigit = cardNumberString.last!
        var digitSum = 0
        let characters = cardNumberString.dropLast().reversed()
        for (index, characters) in cardNumberString.enumerated() {
            let digit = Int(String(characters)) ?? 0
            if index % 2 == 0 {
                var product = digit * 2
                if product > 9 {
                    product = product - 9
                }
                digitSum = digitSum + product
            } else {
                digitSum = digitSum + digit
            }
        }
        return (digitSum % 10) == 0
    }
    var countOTP = 0
    
    func generateOTP() -> String {
        let data = base32DecodeToData("THISISSECRETDATA")!
        let hotp = HOTP(secret: data, digits: 6, algorithm: .sha1)!
        countOTP = countOTP + 1
        return hotp.generate(counter: UInt64(countOTP))
    }
    func showAlertButtonTapped(sender: UIButton, message: String, check: Bool) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: check ? {
            action in self.dismiss(animated: true, completion: nil)
            } : nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupImageView() {
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    func setupInputsContainerView1() {
        cardNumberTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        cardNumberTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        cardNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        cardNumberTextField.heightAnchor.constraint(equalToConstant: 37.5).isActive = true
        
        cardNumberSeparatorFeild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14).isActive = true
        cardNumberSeparatorFeild.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor).isActive = true
        cardNumberSeparatorFeild.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14).isActive = true
        cardNumberSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    func setupInputsContainerView2() {
        nameOnCardTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameOnCardTextField.topAnchor.constraint(equalTo: cardNumberSeparatorFeild.bottomAnchor, constant: 5).isActive = true
        nameOnCardTextField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nameOnCardTextField.heightAnchor.constraint(equalToConstant: 37.5).isActive = true
        
        nameOnCardSeparatorFeild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14).isActive = true
        nameOnCardSeparatorFeild.topAnchor.constraint(equalTo: nameOnCardTextField.bottomAnchor).isActive = true
        nameOnCardSeparatorFeild.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14).isActive = true
        nameOnCardSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    func setupInputsContainerView3() {
        expiryDateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        expiryDateTextField.topAnchor.constraint(equalTo: nameOnCardSeparatorFeild.bottomAnchor, constant: 5).isActive = true
        expiryDateTextField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        expiryDateTextField.heightAnchor.constraint(equalToConstant: 37.5).isActive = true
        
        expiryDateSeparatorFeild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14).isActive = true
        expiryDateSeparatorFeild.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor).isActive = true
        expiryDateSeparatorFeild.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14).isActive = true
        expiryDateSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    func setupInputsContainerView4() {
        securityCodeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        securityCodeTextField.topAnchor.constraint(equalTo: expiryDateSeparatorFeild.bottomAnchor, constant: 5).isActive = true
        securityCodeTextField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        securityCodeTextField.heightAnchor.constraint(equalToConstant: 37.5).isActive = true
        
        securityCodeSeparatorFeild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14).isActive = true
        securityCodeSeparatorFeild.topAnchor.constraint(equalTo: securityCodeTextField.bottomAnchor).isActive = true
        securityCodeSeparatorFeild.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14).isActive = true
        securityCodeSeparatorFeild.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    func setupConfirmPaymentButton() {
        confirmPaymentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmPaymentButton.topAnchor.constraint(equalTo: securityCodeTextField.bottomAnchor, constant: 30).isActive = true
        confirmPaymentButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        confirmPaymentButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
