//
//  ShopViewController.swift
//  ToBeDone
//
//  Created by user230454 on 1/19/23.
//

import UIKit
import FirebaseAuth

class ShopViewController: UIViewController {
    
    var backgroundList = [BackgroundData]()
    var avatarList = [AvatarData]()
    var theme = 0
    private var uid = ""
    private var user = User(username: "", lastName: "", uid: "", firstName: "", totalTasks: 0, doneTasks: 0, coins: 0, background1: 0, background2: 0, background3: 0, background4: 0, avatar1: 0, avatar2: 0, avatar3: 0, avatar4: 0)
    @IBOutlet weak var coins: UILabel!
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet weak var backCollectionView: UICollectionView!
    @IBOutlet weak var screenView: UIView!
    @IBOutlet weak var picker: UISegmentedControl!
    
    fileprivate func applyTheme() {
        backCollectionView.backgroundColor = Theme.current.tableBackground
        screenView.backgroundColor = Theme.current.view
        UITabBar.appearance().barTintColor = Theme.current.view

        self.backCollectionView.reloadData()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .darkContent
    }
    
    @IBAction func pickerButtons(_ sender: Any) {
        self.backCollectionView.reloadData()
        backCollectionView.reloadItems(at: backCollectionView.indexPathsForVisibleItems)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //UINavigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.backCollectionView.delegate = self
        self.backCollectionView.dataSource = self
        fillBackgroundData()
        fillAvatarData()
        applyTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser {
            let id = user.uid
            uid = id
            print(id)
        } else {
            //
        }
        getUser(id: uid) { result in
            switch result {
            case .success(let user):
                self.user = user[0]
                print(self.user)
                if let coins = self.user.coins{
                    DispatchQueue.main.async {
                        self.coins.text = "\(coins) coins"
                    }
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    private func fillBackgroundData() {
        let cell1 = BackgroundData(name: "Light Theme", price: 0, labelColor: .black, backColor: .white, img: UIImageView())
        backgroundList.append(cell1)
        let cell2 = BackgroundData(name: "Dark Theme", price: 0, labelColor: .white, backColor: .black, img: UIImageView())
        backgroundList.append(cell2)
        let cell3 = BackgroundData(name: "Blue Theme", price: 0, labelColor: .white, backColor: .blue, img: UIImageView())
        backgroundList.append(cell3)
        let cell4 = BackgroundData(name: "Red Theme", price: 0, labelColor: .white, backColor: .red, img: UIImageView())
        backgroundList.append(cell4)
        self.backCollectionView.reloadData()
        backCollectionView.reloadItems(at: backCollectionView.indexPathsForVisibleItems)
    }
    
    private func fillAvatarData() {
        let whiteImg = UIImageView()
        let cell1 = AvatarData(name: "Avatar1", price: 0, labelColor: .black, backColor: .white, img: UIImageView())
        avatarList.append(cell1)
        let cell2 = AvatarData(name: "Avatar2", price: 0, labelColor: .white, backColor: .black, img: UIImageView())
        avatarList.append(cell2)
        let cell3 = AvatarData(name: "Avatar3", price: 0, labelColor: .white, backColor: .red, img: UIImageView())
        avatarList.append(cell3)
        let cell4 = AvatarData(name: "Avatar4", price: 0, labelColor: .white, backColor: .red, img: UIImageView())
        avatarList.append(cell4)
        self.backCollectionView.reloadData()
        backCollectionView.reloadItems(at: backCollectionView.indexPathsForVisibleItems)
    }
    
    private func toggleTheme()
    {
        /*if (theme == 0)
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
        }*/
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
        if (picker.selectedSegmentIndex == 0)
        {
            return backgroundList.count
        }
        else
        {
            return backgroundList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (picker.selectedSegmentIndex == 0)
        {
            let cell = backCollectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCollectionViewCell
            cell.label?.text = backgroundList[indexPath.row].name
            cell.price?.text = String(backgroundList[indexPath.row].price)
            cell.layer.cornerRadius = cell.frame.height/8
            cell.labelColor = backgroundList[indexPath.row].labelColor
            cell.backColor = backgroundList[indexPath.row].backColor
            cell.img.backgroundColor = backgroundList[indexPath.row].backColor
            cell.img.layer.cornerRadius = cell.frame.height/8
            /*switch indexPath.row {
            /*case 0:
                if user.background1 == 1
                {
                    cell.is
                }
            default:
                <#code#>
            }*/*/
            
            return cell;
        }
        else
        {
            let cell = backCollectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCollectionViewCell
            cell.label?.text = avatarList[indexPath.row].name
            cell.price?.text = String(avatarList[indexPath.row].price)
            cell.layer.cornerRadius = cell.frame.height/8
            cell.labelColor = avatarList[indexPath.row].labelColor
            cell.backColor = avatarList[indexPath.row].backColor
            cell.img.backgroundColor = avatarList[indexPath.row].backColor
            
            return cell;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if picker.selectedSegmentIndex == 0
        {
            if (indexPath.row == 0)
            {
                theme = 0
                Theme.current = LightTheme()
                toggleTheme()
                print("White Theme")
            }
            else if (indexPath.row == 1)
            {
                theme = 1
                Theme.current = DarkTheme()
                toggleTheme()
                print("Black Theme")
            }
            else if (indexPath.row == 2)
            {
                theme = 2
                Theme.current = BlueTheme()
                toggleTheme()
                print("Blue Theme")
            }
            else if (indexPath.row == 3)
            {
                theme = 2
                Theme.current = RedTheme()
                toggleTheme()
                print("Red Theme")
            }
            applyTheme()
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = (collectionView.frame.size.width-30)/3
//        return CGSize(width:size, height:size)
//    }
    
    
}
