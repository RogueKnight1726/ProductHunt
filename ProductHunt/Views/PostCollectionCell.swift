//
//  PostCollectionCell.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import WebKit


class PostCollectionCell: UICollectionViewCell{
    
    
    var baseView: BaseView!
    var model: Post?
    var thumbnailImageView: UIImageView!
    
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        initViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}



extension PostCollectionCell{
    
    
    
    func initViews(){
        baseView = BaseView.init(with: .white, circular: false, shadow: true, borderColor: nil, borderThickness: nil)
        self.addSubview(baseView)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        [baseView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
         baseView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
         baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
         baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
        
        
        thumbnailImageView = UIImageView.init()
        baseView.addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        [thumbnailImageView.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 0),
         thumbnailImageView.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: 0),
         thumbnailImageView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 0),
         thumbnailImageView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
        thumbnailImageView.load(url: URL.init(string: model?.thumbnail?.image_url ?? "")!)
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
