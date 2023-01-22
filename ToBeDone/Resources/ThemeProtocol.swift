//
//  ThemeProtocol.swift
//  ToBeDone
//
//  Created by user230454 on 1/22/23.
//

import Foundation
import UIKit

protocol ThemeProtocol{
    var fontName : String { get }
    var accent : UIColor { get }
    var tint : UIColor { get }
    var background : UIColor { get }
}
