//
//  FeedCell.swift
//  Shop
//
//  Created by Benz on 28/2/2561 BE.
//  Copyright © 2561 Benz. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var homeController: HomeController?
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var products: [Product] = {
        var backpack = Product()
        backpack.title = "DAVIDJONES Genuine Leather Small Mini Backpack"
        backpack.productImageName = "Bag"
        backpack.price = "$800"
        backpack.subtitle = "Bag"
        
        var inear = Product()
        inear.title = "JBL Inear with Mic. T110 Black "
        inear.productImageName = "inear"
        inear.price = "$490"
        inear.subtitle = "inear"
        
        var perfume = Product()
        perfume.title = "Vera Wang Bouquet EDP 100 ml."
        perfume.productImageName = "perfume"
        perfume.price = "$1900"
        perfume.subtitle = "perfume"
        
        var phone = Product()
        phone.title = "HUAWEI Y7 (Gold)"
        phone.productImageName = "phone"
        phone.price = "$4180"
        phone.subtitle = "phone"
        
        var shirt = Product()
        shirt.title = "Long Sleeve Shirt For Men"
        shirt.productImageName = "shirt"
        shirt.price = "$600"
        shirt.subtitle = "shirt"
        
        var shoe = Product()
        shoe.title = "ADIDAS Coneo QT VS Paris Grey Glow Pink"
        shoe.productImageName = "shoe"
        shoe.price = "$1500"
        shoe.subtitle = "shoe"
        
        var watch = Product()
        watch.title = "Casio G-Shock"
        watch.productImageName = "watch"
        watch.price = "$2200"
        watch.subtitle = "watch"
        
        
        return [backpack, inear, perfume, phone, shirt, shoe, watch]
    }()
    
    let cellId = "cellId"
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .brown
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellId)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ProductCell
        
        cell.product = products[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 72 - 72) * 9 / 16
        return CGSize(width: frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product0 = Product0()
        product0.viewDidLoad()

    }


    
}
