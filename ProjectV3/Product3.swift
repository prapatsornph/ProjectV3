//
//  Product3.swift
//  Shop
//
//  Created by Benz on 22/4/2561 BE.
//  Copyright © 2561 Benz. All rights reserved.
//

import UIKit


class Product3: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate{
    
    let navTitle: UILabel = {
        let Label = UILabel()
        Label.text = "Detail"
        Label.textColor = UIColor.rgb(red: 28, green: 49, blue: 75)
        Label.font = UIFont.boldSystemFont(ofSize: 20)
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "phone")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "HUAWEI Y7 (Gold)"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Detail"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "      สมาร์ทโฟนรุ่นใหม่ที่ถูกปล่อยออกมาเพื่อการใช้งานที่ครอบคลุมได้อย่างครบวงจรของเทคโนโลยีที่สำคัญอย่าง HUAWEI Y7 (Gold) ที่ถูกใจผู้ใช้งานตั้งแต่ภายนอกจนถึงภายใน ที่ทำให้คุณไม่พลาดทุกโอกาสสำคัญระหว่างสมาร์ทโฟนชองคุณ และโลกภายนอก ทุกงาน และสิ่งสำคัญต่อจากนี้คุณจึงสามารถจัดการได้ง่าย ๆ แค่บนสมาร์ทโฟนเครื่องนี้เครื่องเดียว"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "฿4180"
        return label
    }()
    
    
    var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 255, green: 102, blue: 102)
        button.setTitle("Payment", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(payment), for: .touchUpInside)
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.hidesBackButton = true
        
        navigationItem.titleView = navTitle
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(productImageView)
        view.addSubview(titleLabel)
        view.addSubview(detailLabel)
        view.addSubview(textLabel)
        view.addSubview(priceLabel)
        view.addSubview(continueButton)
        
        setupImage()
        setupDetail()
        setupContinueButton()
        
    }
    @objc func backButtonAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupImage() {
        productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        productImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 13).isActive = true
        productImageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -200).isActive = true
        productImageView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -350).isActive = true
        
    }
    
    func setupDetail() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        detailLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 10).isActive = true
        textLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        priceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110).isActive = true
        
    }
    
    func setupContinueButton() {
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func payment(){
        navigationController?.pushViewController(PaymentController(), animated: true)
    }
}
