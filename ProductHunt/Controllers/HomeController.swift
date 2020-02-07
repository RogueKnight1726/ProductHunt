//
//  HomeController.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import WebKit

class HomeController: UIViewController{
    
    var bottoBar: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let postsUrlString = String.URLScheme.POSTS
        guard let postsUrl = URL.init(string: postsUrlString) else {
            print("Invalid URL")
            return
        }
        WebApiClient.shared.requestApi(with: postsUrl, method: .get, params: nil) { [weak self] (error, success, data) in
            if success{
                guard let unwrappedData = data else {
                    self?.onFailureListener(errorMessage: "Oops something went wrong", response: nil)
                    return
                }
                print("Success: \(unwrappedData)")
                self?.onSuccessListener(response: "Success", codableResponse: unwrappedData)
            } else {
                print("Faiure response")
            }
        }
    }
}

extension HomeController: DataResponseListener{
    func onSuccessListener(response: Any, codableResponse: Data) {
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(PostCollection.self, from: codableResponse)
            print("Model : \(model)")
            print("Recieved Fee Response")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func onFailureListener(errorMessage: String, response: Any?) {
        
    }
    
    
}








extension HomeController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath) as! CollectionCell
        return cell
    }
}






extension HomeController{
    
    func initViews(){
        
    }
}

