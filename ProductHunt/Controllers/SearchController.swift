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
    }
}
