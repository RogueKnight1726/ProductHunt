//
//  BottomBarCell.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit



class BottomBarCell: UICollectionViewCell{
    
    var icon: UIImageView!
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        initViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}



extension BottomBarCell{
    
    
    func initViews(){
        
        icon = UIImageView()
        self.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        [icon.heightAnchor.constraint(equalToConstant: 40),
         icon.widthAnchor.constraint(equalToConstant: 40),
         icon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
         icon.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)].forEach({$0.isActive = true})
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage.init(named: "bottomHomeImage")
        icon.alpha = 0.3
    }
}
