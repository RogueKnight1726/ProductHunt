//
//  PostDetailController.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import WebKit

class PostDetailController: BaseController{
    
    
    var layout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    var avatarWebView: WKWebView!
    
    
    var model: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
}




extension PostDetailController{
    
    func initViews(){
        
        avatarWebView = WKWebView()
        view.addSubview(avatarWebView)
        avatarWebView.translatesAutoresizingMaskIntoConstraints = false
        [avatarWebView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
         avatarWebView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
         avatarWebView.widthAnchor.constraint(equalToConstant: 80),
         avatarWebView.heightAnchor.constraint(equalToConstant: 80)].forEach({$0.isActive = true})
        avatarWebView.scrollView.isScrollEnabled = false
        avatarWebView.layer.cornerRadius = 40
        avatarWebView.clipsToBounds = true
        if let url = URL.init(string: model?.thumbnail?.image_url ?? "") {
            avatarWebView.load(URLRequest.init(url: url))
        }
        
        
        let postTitlelabel = UILabel()
        view.addSubview(postTitlelabel)
        postTitlelabel.translatesAutoresizingMaskIntoConstraints = false
        [postTitlelabel.leftAnchor.constraint(equalTo: avatarWebView.rightAnchor, constant: 16),
         postTitlelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)].forEach({$0.isActive = true})
        postTitlelabel.text =  model.name ?? ""
        postTitlelabel.lineBreakMode = .byTruncatingTail
        postTitlelabel.textColor = .black
        postTitlelabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        let subTitleLabel = UILabel()
        view.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        [subTitleLabel.leftAnchor.constraint(equalTo: postTitlelabel.leftAnchor, constant: 0),
         subTitleLabel.topAnchor.constraint(equalTo: postTitlelabel.bottomAnchor, constant: 8),
         subTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)].forEach({$0.isActive = true})
        subTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        subTitleLabel.numberOfLines = 2
        subTitleLabel.lineBreakMode = .byTruncatingTail
        subTitleLabel.textColor = .gray
        subTitleLabel.text = model?.tagline
        
        let seperator = UIView()
        view.addSubview(seperator)
        seperator.backgroundColor = .lightGray
        seperator.translatesAutoresizingMaskIntoConstraints = false
        [seperator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         seperator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         seperator.heightAnchor.constraint(equalToConstant: 1),
         seperator.topAnchor.constraint(equalTo: avatarWebView.bottomAnchor, constant: 16)].forEach({$0.isActive = true})
        seperator.alpha = 0.2
    }
}
