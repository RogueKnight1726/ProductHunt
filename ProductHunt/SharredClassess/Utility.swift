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
        static let COMMENTS = BASE_URL + "/posts/{POST_ID}/comments?page={PAGENUMBER}&per_page={PAGESIZE}"
    }
}


extension UIColor{
    
    
    struct AppTheme {
        static let appBackgroundColor = UIColor(red:0.86, green:0.89, blue:0.91, alpha:1.0)
        static let bottomBarColor = UIColor.white
        static let bottomBarSelectionColoe = UIColor(red:0.34, green:0.41, blue:0.58, alpha:1.0)
        static let cellOneColor = UIColor(red:0.88, green:0.54, blue:0.53, alpha:1.0)
        static let cellTwoColor = UIColor(red:0.31, green:0.29, blue:0.52, alpha:1.0)
        static let cellThreeColor = UIColor(red:0.94, green:0.68, blue:0.44, alpha:1.0)
        static let cellFourColor = UIColor(red:0.75, green:0.75, blue:0.82, alpha:1.0)
        static let replyCellBackgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    }
}

