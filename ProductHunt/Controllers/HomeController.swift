//
//  HomeController.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import WebKit

class HomeController: BaseController{
    
    var bottoBar: BaseView!
    var layout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    var postsArray: PostCollection?
    var guide: UILayoutGuide!
    var greetingsLabel: UILabel!
    var postHeadline: UILabel!
    var cellColors = [UIColor]()
    var colorSet = [UIColor.AppTheme.cellOneColor,UIColor.AppTheme.cellTwoColor,UIColor.AppTheme.cellThreeColor,UIColor.AppTheme.cellFourColor]
    weak var selectionDelegate: PostSelectionProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initViews()
        getData()
    }
    
    
    func getData(){
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
            postsArray = try decoder.decode(PostCollection.self, from: codableResponse)
            postsArray?.posts?.forEach({ _ in cellColors.append(colorSet.randomElement() ?? UIColor.white) })
            collectionView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func onFailureListener(errorMessage: String, response: Any?) {
        
    }
    
    
}








extension HomeController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsArray?.posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath) as! PostCollectionCell
        cell.model = postsArray?.posts?[indexPath.row]
        cell.backColor = cellColors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let unwrappedPost = postsArray?.posts?[indexPath.row] else {
            //handle this
            return
        }
        selectionDelegate?.selectedProtocol(with: unwrappedPost)
    }
}






extension HomeController{
    
    
    func initViews(){
        
        
        guide = view.safeAreaLayoutGuide
        greetingsLabel = UILabel()
        view.addSubview(greetingsLabel)
        greetingsLabel.translatesAutoresizingMaskIntoConstraints = false
        [greetingsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
         greetingsLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16)].forEach({$0.isActive = true})
        greetingsLabel.text = "Greetings"
        greetingsLabel.textColor = .black
        greetingsLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        
        
        postHeadline = UILabel()
        view.addSubview(postHeadline)
        postHeadline.translatesAutoresizingMaskIntoConstraints = false
        [postHeadline.leftAnchor.constraint(equalTo: greetingsLabel.leftAnchor, constant: 8),
         postHeadline.topAnchor.constraint(equalTo: greetingsLabel.bottomAnchor, constant: 8)].forEach({$0.isActive = true})
        postHeadline.text = "Today's posts"
        postHeadline.font = UIFont.systemFont(ofSize: 18, weight: .light)
        postHeadline.textColor = .gray
        
        
        layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 170, height: 150)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         collectionView.heightAnchor.constraint(equalToConstant: 150),
         collectionView.topAnchor.constraint(equalTo: postHeadline.bottomAnchor, constant: 16)].forEach({$0.isActive = true})
        collectionView.backgroundColor = .clear
        collectionView.register(PostCollectionCell.self, forCellWithReuseIdentifier: "SomeIdentifier")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.clipsToBounds = false
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        
        
        
    }
}

