//
//  CollectionCell.swift
//  ProductHunt
//
//  Created by SWAT on 08/02/20.
//  Copyright © 2020 SWAT. All rights reserved.
//

import UIKit
import WebKit


class CollectionCell: UICollectionViewCell{
    
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        initViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


extension CollectionCell{
    
    
    func initViews(){
        let webView = WKWebView.init()
        self.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        [webView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
         webView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
         webView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
         webView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)].forEach({$0.isActive = true})
        
        webView.load(URLRequest.init(url: URL.init(string: "https://ph-files.imgix.net/8433087d-353a-48ff-847f-87ee9ad88761?auto=format&fit=crop&h=570&w=430")!))
        webView.scrollView.isScrollEnabled = false
    }
}
