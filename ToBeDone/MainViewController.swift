//
//  MainViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 26.10.2022.
//  Modified by Andrei Tatucu on 02.11.2022. 
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

class MainViewController: UIViewController {
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var screenView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logo: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.bounds.size.height/2
        registerButton.layer.cornerRadius = registerButton.bounds.size.height/2
        loginButton.isHidden = true
        registerButton.isHidden = true
        logo.layer.cornerRadius = logo.frame.width/2
        logoImage.layer.cornerRadius = logo.frame.width/3
        self.screenView.layer.cornerRadius = 10
        
    }
    
    @IBAction func toggleDarkMode(_ sender: Any) {
        if darkModeSwitch.isOn
        {
            logo.backgroundColor = .black
            view.backgroundColor = .black
            screenView.backgroundColor = UIColor(hex: "#1c1c20FF")
//            screenView.backgroundColor = .gray
            loginButton.backgroundColor = .gray
            loginButton.setTitleColor(.white, for: .normal)
            registerButton.backgroundColor = .gray
            registerButton.setTitleColor(.white, for: .normal)
        }
        else
        {
            logo.backgroundColor = .systemBlue
            view.backgroundColor = .systemBlue
            screenView.backgroundColor = .systemBackground
            loginButton.backgroundColor = .systemBlue
            registerButton.backgroundColor = .systemGray3
        }
                
    }
    func animateLogo()
    {
        UIView.animate(withDuration: 2.0, delay: 1.2, options: .curveEaseIn, animations: {
            self.logo.transform = CGAffineTransform(translationX: 0, y: -200)
            self.logo.transform = self.logo.transform.scaledBy(x: 0.75, y: 0.75)
        }, completion: { success in
           print("succes animation")
            self.showButtons()
        })
    }
    
    func showButtons()
    {
        self.loginButton.isHidden = false
        self.registerButton.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateLogo()
    }
}
