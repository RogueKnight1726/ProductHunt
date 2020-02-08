//
//  Utility.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import Foundation
import UIKit



extension String{
    
    struct URLScheme{
        static let BASE_URL = "https://api.producthunt.com/v1/"
        static let POSTS = BASE_URL + "posts"
    }
}


extension UIColor{
    
    
    struct AppTheme {
        static let appBackgroundColor = UIColor(red:0.86, green:0.89, blue:0.91, alpha:1.0)
        static let bottomBarColor = UIColor.white
    }
}
