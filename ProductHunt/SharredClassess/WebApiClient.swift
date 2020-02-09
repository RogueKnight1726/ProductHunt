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
    
    
    
    //Method to handle multiple requests at once and give priority to the last requested call
    func requestApiWithUUid(with url: URL,method: HTTPMethod, params: [String: Any]?,requestId: String ,completion: @escaping (_ error: String?,_ success: Bool,_ data: Data?,_ requestId: String) -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer DKEDMw3RmjOurQxMBZ3r7EQjZd4eOH8Lzu2jTKw1tsQ"
        ]
        Alamofire.request(url, method: method
            , parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseData { (response) in

                if response.result.isFailure{
                    completion("Error Response", false, nil,requestId)
                    return
                }
                guard let dataResponse = response.data else {
                    completion("No data response", false, nil,requestId)
                    return
                }
                completion(nil, true, dataResponse,requestId)
        }
    }
}


protocol DataResponseListener{
    func onSuccessListener(response: Any,codableResponse: Data)
    func onFailureListener(errorMessage: String, response: Any?)
}
