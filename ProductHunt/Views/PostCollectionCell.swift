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
    
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var baseView: BaseView!
    var commentNumberLabel: UILabel!
    var commentIcon: UIImageView!
    var model: Post?{
        didSet{
            subTitleLabel.text = model?.tagline ?? ""
            titleLabel.text = model?.name ?? ""
            commentNumberLabel.text = "\(model?.comments_count ?? 0)"
        }
    }
    var thumbnailImageView: UIImageView!
    var backColor: UIColor!{
        didSet{
            baseView.setColorToBaseView(color: backColor)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseView = BaseView.init(with: .white, circular: false, shadow: true, borderColor: nil, borderThickness: nil)
        self.addSubview(baseView)
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        subTitleLabel = UILabel()
        self.addSubview(subTitleLabel)
        commentIcon = UIImageView()
        self.addSubview(commentIcon)
        commentNumberLabel = UILabel()
        self.addSubview(commentNumberLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}



extension PostCollectionCell{
    
    
    
    func initViews(){
        
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        [baseView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
         baseView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
         baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
         baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
        
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        [titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
         titleLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
         titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)].forEach({$0.isActive  = true})
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        [subTitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0),
         subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
         subTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)].forEach({$0.isActive = true})
        subTitleLabel.numberOfLines = 2
        subTitleLabel.lineBreakMode = .byTruncatingTail
        subTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        subTitleLabel.textColor = .white
        
        
        
        
        commentIcon.translatesAutoresizingMaskIntoConstraints = false
        [commentIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
         commentIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
         commentIcon.heightAnchor.constraint(equalToConstant: 18),
         commentIcon.widthAnchor.constraint(equalToConstant: 18)].forEach({$0.isActive = true})
        commentIcon.image = UIImage.init(named: "commentIcon")
        commentIcon.contentMode = .scaleAspectFit
        
        
        commentNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        [commentNumberLabel.leftAnchor.constraint(equalTo: commentIcon.rightAnchor, constant: 4),
         commentNumberLabel.centerYAnchor.constraint(equalTo: commentIcon.centerYAnchor, constant: 0)].forEach({$0.isActive = true})
        commentNumberLabel.textColor = .white
        commentNumberLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
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
