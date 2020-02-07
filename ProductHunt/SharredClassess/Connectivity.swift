//
//  Connectivity.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
