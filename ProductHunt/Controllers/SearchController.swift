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
    var postsArray: PostCollection?
    weak var selectionDelegate: PostSelectionProtocol?
    var filteredList: [Post] = []{
        didSet{
            collectionView.isHidden = filteredList.isEmpty
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initViews()
        getSavedData()
    }
    
    
    func getSavedData(){
        FileManagerHelper.shared.readOfflineData { [weak self] (success, collectionResponse) in
            if success{
                self?.postsArray = collectionResponse
                
                self?.collectionView.reloadData()
            }
        }
    }
    
    func filterPosts(with searchText: String){
        filteredList = []
        collectionView.reloadData()
        
        if let matchingCases = postsArray?.posts?.filter({ $0.name?.lowercased().contains(searchText.lowercased()) ?? false}){
            filteredList.append(contentsOf: matchingCases)
        }
        if let matchingCases = postsArray?.posts?.filter({ $0.tagline?.lowercased().contains(searchText.lowercased()) ?? false}){
            
            //This is added just to avoid duplicate copies. Else the previous higherorder function could have been used here.
            for postObject in matchingCases{
                if !filteredList.contains(where: {$0.id == postObject.id}){
                    filteredList.append(postObject)
                }
            }
            
        }
        UIView.performWithoutAnimation {
            let contentOffset = self.collectionView.contentOffset.y
            self.collectionView.reloadData()
            self.collectionView.contentOffset.y = contentOffset
        }
        
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
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.tintColor = .black
        searchBar.searchTextField.textColor = .black
        searchBar.barTintColor = UIColor.AppTheme.appBackgroundColor
        
        let tappableView = UIView()
        view.addSubview(tappableView)
        tappableView.translatesAutoresizingMaskIntoConstraints = false
        [tappableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
         tappableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         tappableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         tappableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
        
        
        layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: self.view.bounds.width, height: 120)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.AppTheme.appBackgroundColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 4),
         collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
        collectionView.register(SearchCollectionCell.self, forCellWithReuseIdentifier: "SomeIdentifier")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        
        tappableView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapOutsideGestureDetected)))
    }
    
    
    @objc func tapOutsideGestureDetected(){
        searchBar.resignFirstResponder()
    }
    
}



extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath) as! SearchCollectionCell
        cell.model = filteredList[indexPath.row]
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let unwrappedPost = postsArray?.posts?[indexPath.row] else {
            //handle this
            return
        }
        selectionDelegate?.selectedProtocol(with: unwrappedPost)
    }
}



extension SearchController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterPosts(with: searchText)
    }
}
