//
//  MenuBar.swift
//  Shop
//
//  Created by Benz on 26/2/2561 BE.
//  Copyright © 2561 Benz. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = UIColor.rgb(red: 106, green: 148, blue: 199)
//        cv.dataSource = self
//        cv.delegate = self
//        return cv
//    }()
//
//    let cellId = "cellId"
//    let imageNames = ["home", "search", "user"]
//
//    var homeController: HomeController?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        backgroundColor = UIColor.rgb(red: 106, green: 148, blue: 199)
//
//        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
//
//        addSubview(collectionView)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
//        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
//
//        let selectedIndexPath = NSIndexPath(row: 0, section: 0)
//        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        homeController?.scrolltoMenuIndex(menuIndex: indexPath.item)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
//
//        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
//        cell.tintColor = UIColor.white
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: frame.width / 3, height: frame.height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class MenuCell: BaseCell {
//
//    let imageView: UIImageView = {
//        let iv = UIImageView()
//        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
//        iv.tintColor = UIColor.white
//        return iv
//    }()
//
//    override var isSelected: Bool {
//        didSet {
//            imageView.tintColor = isSelected ? UIColor.rgb(red: 28, green: 49, blue: 75) : UIColor.white
//        }
//    }
//
//    override func setupViews() {
//        super.setupViews()
//
//        addSubview(imageView)
//        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
//        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
//
//        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
//
//    }
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 106, green: 148, blue: 199)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    let imageNames = ["home", "search", "user"]
    
    var homeController: HomeController?
    var searchController: SearchController?
    var accountController: AccountController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.rgb(red: 106, green: 148, blue: 199)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = NSIndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.white
        return iv
    }()
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.rgb(red: 28, green: 49, blue: 75) : UIColor.white
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }

    }

