//
//  SearchResultCell.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit

class SearchCollectionCell: UICollectionViewCell{
    
    var model: Post!{
        didSet{
            nameLabel.text = model.name ?? ""
            tagLineLabel.text = model.tagline ?? ""
            thumbnailImageView.kf.setImage(
                with: URL.init(string: model?.thumbnail?.image_url ?? ""),
                placeholder: nil,
                options: [.transition(.fade(0)), .loadDiskFileSynchronously],
                progressBlock: { receivedSize, totalSize in
            },
                completionHandler: { _ in
            })
            makerThumbnail.kf.setImage(
                with: URL.init(string: model?.makers?.first?.image_url?.imageSize ?? ""),
                placeholder: nil,
                options: [.transition(.fade(0)), .loadDiskFileSynchronously],
                progressBlock: { receivedSize, totalSize in
            },
                completionHandler: { _ in
            })
        }
    }
    var thumbnailImageView: UIImageView!
    var nameLabel: UILabel!
    var tagLineLabel: UILabel!
    var makerThumbnail: UIImageView!
    var seperator: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}



extension SearchCollectionCell{
    
    
    func initViews(){
        self.backgroundColor = .white
        
        thumbnailImageView = UIImageView()
        self.addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        [thumbnailImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
         thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
         thumbnailImageView.heightAnchor.constraint(equalToConstant: 60),
         thumbnailImageView.widthAnchor.constraint(equalToConstant: 60)].forEach({$0.isActive = true})
        thumbnailImageView.layer.cornerRadius = 30
        thumbnailImageView.backgroundColor = .lightGray
        thumbnailImageView.clipsToBounds = true
        
        nameLabel = UILabel()
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        [nameLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 16),
         nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)].forEach({$0.isActive = true})
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        tagLineLabel = UILabel()
        self.addSubview(tagLineLabel)
        tagLineLabel.translatesAutoresizingMaskIntoConstraints = false
        [tagLineLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 8),
         tagLineLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
         tagLineLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)].forEach({$0.isActive = true})
        tagLineLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        tagLineLabel.textColor = .black
        
        makerThumbnail = UIImageView()
        self.addSubview(makerThumbnail)
        makerThumbnail.translatesAutoresizingMaskIntoConstraints = false
        [makerThumbnail.leftAnchor.constraint(equalTo: tagLineLabel.leftAnchor, constant: 8),
         makerThumbnail.topAnchor.constraint(equalTo: tagLineLabel.bottomAnchor, constant: 8),
         makerThumbnail.heightAnchor.constraint(equalToConstant: 40),
         makerThumbnail.widthAnchor.constraint(equalToConstant: 40)].forEach({$0.isActive = true})
        makerThumbnail.backgroundColor = .darkGray
        makerThumbnail.layer.cornerRadius = 20
        makerThumbnail.clipsToBounds = true
        
        
        
        
        
        seperator = UIView()
        self.addSubview(seperator)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        [seperator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
         seperator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
         seperator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
         seperator.heightAnchor.constraint(equalToConstant: 1)].forEach({$0.isActive = true})
        seperator.backgroundColor = UIColor.AppTheme.appBackgroundColor
        
        
    }
}
