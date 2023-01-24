//
//  ShopList.swift
//  ToBeDone
//
//  Created by user230454 on 1/20/23.
//

import Foundation
import UIKit

class AvatarData {
    var name:String
    var price:Int
    var labelColor: UIColor
    var backColor: UIColor
    var img:UIImageView
    
    init(name: String, price: Int, labelColor : UIColor, backColor : UIColor, img: UIImageView) {
        self.name = name
        self.price = price
        self.labelColor = labelColor
        self.backColor = backColor
        self.img = img
    }
}

class BackgroundData {
    var name:String
    var price:Int
    var labelColor: UIColor
    var backColor: UIColor
    var img:UIImageView
    
    init(name: String, price: Int, labelColor : UIColor, backColor : UIColor, img : UIImageView) {
        self.name = name
        self.price = price
        self.labelColor = labelColor
        self.backColor = backColor
        self.img = img
    }
}
