//
//  SearchController.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit

class SearchController: BaseController{
    
    
    var searchBar: UISearchBar!
    var layout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initViews()
    }
}



extension SearchController{
    
    
    func initViews(){
        searchBar = UISearchBar()
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        [searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
         searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
         searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 8)].forEach({$0.isActive = true})
        searchBar.placeholder = "Search for posts"
        searchBar.barStyle = .default
        searchBar.searchTextField.backgroundColor = .white
        searchBar.barTintColor = UIColor.AppTheme.appBackgroundColor
        
        
        layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize.init(width: self.view.bounds.width, height: 240)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 4),
         collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SomeIdentifier")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
}



extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath)
        return cell
    }
    
    
}
