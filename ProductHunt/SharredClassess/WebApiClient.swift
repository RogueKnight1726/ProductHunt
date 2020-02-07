//
//  WebApiClient.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import Foundation
import Alamofire


class WebApiClient: NSObject {


    public static var shared = WebApiClient()
    var cookieArray: [HTTPCookie]!
    
    func requestApi(with url: URL,method: HTTPMethod, params: [String: Any]?,completion: @escaping (_ error: String?,_ success: Bool,_ data: Data?) -> Void) {
        
        if !Connectivity.isConnectedToInternet{
            completion("No Internet", false, nil)
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer DKEDMw3RmjOurQxMBZ3r7EQjZd4eOH8Lzu2jTKw1tsQ"
        ]
        Alamofire.request(url, method: method
            , parameters: params, encoding: URLEncoding.default, headers: headers).responseData { (response) in
                
                if response.result.isFailure{
                    completion("Error Response", false, nil)
                    completion(nil, false, nil)
                    return
                }
                guard let dataResponse = response.data else {
                    completion("No data response", false, nil)
                    
                    return
                }
                completion(nil, true, dataResponse)
        }
    }
}


protocol DataResponseListener{
    func onSuccessListener(response: Any,codableResponse: Data)
    func onFailureListener(errorMessage: String, response: Any?)
}
