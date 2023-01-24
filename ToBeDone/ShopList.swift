//
//  ShopList.swift
//  ToBeDone
//
//  Created by user230454 on 1/20/23.
//

import Foundation
import UIKit

class ShopData {
    var name:String
    var price:Int
    var labelColor: UIColor
    var backColor: UIColor
    
    init(name: String, price: Int, labelColor : UIColor, backColor : UIColor) {
        self.name = name
        self.price = price
        self.labelColor = labelColor
        self.backColor = backColor
    }
}
