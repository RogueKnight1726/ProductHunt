//
//  ThreadReplyCell.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import Kingfisher

class ThreadReplyCell: UICollectionViewCell{
    
    var avatarImageView: UIImageView!
    var usernameLabel: UILabel!
    var contentLabel: UILabel!
    var upvoteLabel: UILabel!
    var upvoteCount = 0
    var seperator: UIView!
    var creatorView : BaseView!
    var creatorLabel: UILabel!
    var model: Comment?{
        didSet{
            contentLabel.text = model?.body ?? ""
            upvoteLabel.text = "Upvotes (\(model?.votes ?? upvoteCount))"
            usernameLabel.text = model?.user?.name ?? ""
            creatorView.isHidden = !(model?.maker ?? false)
            self.backgroundColor = (model?.isParentComment ?? false) ? .white : UIColor.AppTheme.replyCellBackgroundColor
            avatarImageView.kf.setImage(
                with: URL.init(string: model?.user?.image_url?.url ?? ""),
                placeholder: nil,
                options: [.transition(.fade(0)), .loadDiskFileSynchronously],
                progressBlock: { receivedSize, totalSize in
            },
                completionHandler: { _ in
            })
            
            
        }
    }
    
    
    
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


extension ThreadReplyCell{
    
    
    func initViews(){
        
        
        
        
        avatarImageView = UIImageView.init()
        self.addSubview(avatarImageView)
        usernameLabel = UILabel()
        self.addSubview(usernameLabel)
        contentLabel = UILabel()
        self.addSubview(contentLabel)
        upvoteLabel = UILabel()
        self.addSubview(upvoteLabel)
        seperator = UIView()
        self.addSubview(seperator)
        
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        [avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
         avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
         avatarImageView.widthAnchor.constraint(equalToConstant: 60),
         avatarImageView.heightAnchor.constraint(equalToConstant: 60)].forEach({$0.isActive = true})
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = .lightGray
        
        
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        [usernameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
         usernameLabel.bottomAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: -4),
         usernameLabel.widthAnchor.constraint(equalToConstant: self.bounds.width - 108),
         usernameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)].forEach({$0.isActive = true})
        usernameLabel.textColor = .black
        usernameLabel.numberOfLines = 1
        usernameLabel.lineBreakMode = .byTruncatingTail
        usernameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        
        
        creatorView = BaseView.init(with: UIColor.AppTheme.makerColor, circular: false, shadow: false, borderColor: nil, borderThickness: nil)
        self.addSubview(creatorView)
        creatorView.translatesAutoresizingMaskIntoConstraints = false
        [creatorView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
         creatorView.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor, constant: 0)].forEach({$0.isActive = true})
        
        creatorLabel = UILabel()
        self.addSubview(creatorLabel)
        creatorLabel.translatesAutoresizingMaskIntoConstraints = false
        [creatorLabel.leftAnchor.constraint(equalTo: creatorView.leftAnchor, constant: 16),
         creatorLabel.rightAnchor.constraint(equalTo: creatorView.rightAnchor, constant: -16),
         creatorLabel.topAnchor.constraint(equalTo: creatorView.topAnchor, constant: 4),
         creatorLabel.bottomAnchor.constraint(equalTo: creatorView.bottomAnchor, constant: -4)].forEach({$0.isActive = true})
        creatorLabel.text = "MAKER"
        creatorLabel.font = UIFont.systemFont(ofSize: 9, weight: .light)
        creatorLabel.textColor = .white



        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        [contentLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
         contentLabel.topAnchor.constraint(equalTo: creatorView.bottomAnchor, constant: 4),
         contentLabel.widthAnchor.constraint(equalToConstant: self.bounds.width - 132)].forEach({$0.isActive = true})
        contentLabel.textColor = .black
        contentLabel.numberOfLines = -1
        contentLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        
        
        
        upvoteLabel.translatesAutoresizingMaskIntoConstraints = false
        [upvoteLabel.leftAnchor.constraint(equalTo: contentLabel.leftAnchor, constant: 16),
         upvoteLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 16),
         upvoteLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)].forEach({$0.isActive = true})
        upvoteLabel.textColor = .lightGray
        upvoteLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)


        seperator.backgroundColor = .lightGray
        seperator.translatesAutoresizingMaskIntoConstraints = false
        [seperator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
         seperator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
         seperator.heightAnchor.constraint(equalToConstant: 1),
         seperator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
        seperator.alpha = 0.2
    }
    
}


