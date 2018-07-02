//
//  ViewController.swift
//  Shop
//
//  Created by Benz on 21/2/2561 BE.
//  Copyright © 2561 Benz. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    let cellId = "cellId"
//    let searchCellId = "searchCellId"
//    let titles = ["Home", "Search", "Account"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        navigationController?.navigationBar.isTranslucent = false
//
//        let titleLabel = UILabel()
//        titleLabel.text = "Home"
//        titleLabel.textColor = UIColor.rgb(red: 28, green: 49, blue: 75)
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        navigationItem.titleView = titleLabel
//
//        setupCollectionView()
//        setupMenuBar()
//    }
//
//
//    func setupCollectionView() {
//        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.scrollDirection = .horizontal
//            flowLayout.minimumLineSpacing = 0
//        }
//        collectionView?.backgroundColor = UIColor.white
//
//        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView?.register(SearchCell.self, forCellWithReuseIdentifier: searchCellId)
//
//        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0)
//
//        collectionView?.isPagingEnabled = true
//    }
//
//    func scrolltoMenuIndex(menuIndex: Int) {
//        let indexPath = NSIndexPath(item: menuIndex, section: 0)
//        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
//
//        setTitleForIndex(index: menuIndex)
//    }
//
//    private func setTitleForIndex(index: Int) {
//        if let titleLabel = navigationItem.titleView as? UILabel {
//            titleLabel.text = titles[index]
//        }
//    }
//
//    lazy var menuBar: MenuBar = {
//        let mb = MenuBar()
//        mb.homeController = self
//        return mb
//    }()
//
//    private func setupMenuBar() {
//        view.addSubview(menuBar)
//        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
//        view.addConstraintsWithFormat(format: "V:[v0(50)]|", views: menuBar)
//    }
//
//    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//        let index = targetContentOffset.pointee.x / view.frame.width
//
//        let indexPath = NSIndexPath(item: Int(index), section: 0)
//        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
//
//
//        setTitleForIndex(index: Int(index))
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//
//        if indexPath.item == 1 {
//            return collectionView.dequeueReusableCell(withReuseIdentifier: searchCellId, for: indexPath)
//        }
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: view.frame.height - 50)
//    }
    let cellId = "cellId"

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.rgb(red: 28, green: 49, blue: 75)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.titleView = titleLabel
        
        setupCollectionView()

       
    }
    
    
    func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.white
        

        collectionView?.register(ProductCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0)
        
    }

//    func ChangePage(index: Int) {
//        if index == 0 {
//           navigationController?.pushViewController(HomeController(), animated: true)
//        }
//        if index == 1 {
//           navigationController?.pushViewController(SearchController(), animated: true)
//        }
//        if index == 2{
//            navigationController?.pushViewController(AccountController(), animated: true)
//        }
//    }
//    
//    lazy var menuBar: MenuBar = {
//        let mb = MenuBar()
//        mb.homeController = self
//        return mb
//    }()
//
//    private func setupMenuBar() {
//        view.addSubview(menuBar)
//        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
//        view.addConstraintsWithFormat(format: "V:[v0(50)]|", views: menuBar)
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCell
        
        cell.product = products[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 72 - 72) * 9 / 16
        return CGSize(width: view.frame.width, height: height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            navigationController?.pushViewController(Product0(), animated: true)
        }else if indexPath.item == 1 {
            navigationController?.pushViewController(Product1(), animated: true)
        }else if indexPath.item == 2 {
            navigationController?.pushViewController(Product2(), animated: true)
        }else if indexPath.item == 3 {
            navigationController?.pushViewController(Product3(), animated: true)
        }else if indexPath.item == 4 {
            navigationController?.pushViewController(Product4(), animated: true)
        }else if indexPath.item == 5 {
            navigationController?.pushViewController(Product5(), animated: true)
        }else if indexPath.item == 6 {
            navigationController?.pushViewController(Product6(), animated: true)
        }
    }
    
    
    
    

    
    
    
}
