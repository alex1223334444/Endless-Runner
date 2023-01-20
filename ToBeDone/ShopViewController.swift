//
//  ShopViewController.swift
//  ToBeDone
//
//  Created by user230454 on 1/19/23.
//

import UIKit

class ShopViewController: UIViewController {
    
    var list = [ShopData]()
    var theme = 0
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet weak var backCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backCollectionView.delegate = self
        self.backCollectionView.dataSource = self
        fillData()
    }
    
    private func fillData() {
        let cell1 = ShopData(pic: "", name: "No Background", price: 0)
        list.append(cell1)
        let cell2 = ShopData(pic: "", name: "Red Theme", price: 0)
        list.append(cell2)
        let cell3 = ShopData(pic: "", name: "Blue Theme", price: 0)
        list.append(cell3)
        self.backCollectionView.reloadData()
    }
    
    @IBOutlet weak var screenView: UIView!
    
    private func toggleTheme()
    {
        if (theme == 0)
        {
            navBar.backgroundColor = .white
            self.backCollectionView.backgroundColor = UIColor.clear
            self.backCollectionView.reloadData()
//            navBar.color
            
//            logo.backgroundColor = .black
//            view.backgroundColor = .black
//            screenView.backgroundColor = UIColor(hex: "#1c1c20FF")
////            screenView.backgroundColor = .gray
//            loginButton.backgroundColor = .gray
//            loginButton.setTitleColor(.white, for: .normal)
//            registerButton.backgroundColor = .gray
//            registerButton.setTitleColor(.white, for: .normal)
        }
        else if theme == 2
        {
            //navBar.backgroundColor = .white
            tabBar.badgeColor = .white
            //screenView.tintColor = .black
            self.backCollectionView.backgroundColor = UIColor.red
            self.backCollectionView.reloadData()
            tabBar
//            logo.backgroundColor = .systemBlue
//            view.backgroundColor = .systemBlue
//            screenView.backgroundColor = .systemBackground
//            loginButton.backgroundColor = .systemBlue
//            registerButton.backgroundColor = .systemGray3
        }
        else
        {
            //navBar.backgroundColor = .white
            tabBar.badgeColor = .white
            //screenView.tintColor = .black
            self.backCollectionView.backgroundColor = UIColor.blue
            self.backCollectionView.reloadData()
            tabBar
//            logo.backgroundColor = .systemBlue
//            view.backgroundColor = .systemBlue
//            screenView.backgroundColor = .systemBackground
//            loginButton.backgroundColor = .systemBlue
//            registerButton.backgroundColor = .systemGray3
        }
    }
    

    /*
    // MARK: - Navigationsquare.and.arrow.up

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ShopViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = backCollectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCollectionViewCell
        cell.img?.image = UIImage(named: list[indexPath.row].pic)
        cell.label?.text = list[indexPath.row].name
        cell.price?.text = String(list[indexPath.row].price)
        
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 0)
        {
            theme = 0
            toggleTheme()
            print("White Theme")
        }
        else if (indexPath.row == 1)
        {
            theme = 1
            toggleTheme()
            print("Black Theme")
        }
        else if (indexPath.row == 2)
        {
            theme = 2
            toggleTheme()
            print("Black Theme")
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = (collectionView.frame.size.width-30)/3
//        return CGSize(width:size, height:size)
//    }
    
    
}
