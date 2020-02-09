//
//  FileManagerHelper.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import Foundation

class FileManagerHelper{
    
    public static var shared = FileManagerHelper()
    
    
    func readOfflineData(completion: @escaping (_ success: Bool,_ data: PostCollection?) -> Void){
        let fileManager = FileManager.default
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let filePath = doumentDirectoryPath.appendingPathComponent("SavedResponse.json")
        if fileManager.fileExists(atPath: filePath){
            do{
                let decoder = JSONDecoder()
                let codableData = try Data(contentsOf: URL.init(fileURLWithPath: filePath))
                let postsArray = try decoder.decode(PostCollection.self, from: codableData)
                completion(true,postsArray)
            } catch let error{
                print("Error: \(error)")
                completion(false,nil)
            }
        } else {
            completion(false,nil)
        }
    }
    
}
