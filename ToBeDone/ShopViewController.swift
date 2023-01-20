//
//  ShopViewController.swift
//  ToBeDone
//
//  Created by user230454 on 1/19/23.
//

import UIKit

class ShopViewController: UIViewController {
    
    var list = [ShopData]()
    
    @IBOutlet weak var backCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backCollectionView.delegate = self
        self.backCollectionView.dataSource = self
        fillData()
    }
    
    private func fillData() {
        let cell1 = ShopData(pic: "tick", name: "pula", price: 69)
        list.append(cell1)
        let cell2 = ShopData(pic: "tick", name: "pula", price: 69)
        list.append(cell2)
        let cell3 = ShopData(pic: "tick", name: "pula", price: 69)
        list.append(cell3)
        let cell4 = ShopData(pic: "tick", name: "pula", price: 69)
        list.append(cell4)
        self.backCollectionView.reloadData()
    }
    

    /*
    // MARK: - Navigation

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
        print("You selected item haha")
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = (collectionView.frame.size.width-30)/3
//        return CGSize(width:size, height:size)
//    }
    
    
}
