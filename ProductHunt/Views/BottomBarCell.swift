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
    var descriptionLabel: UILabel!
    
    override var isSelected: Bool{
        didSet{
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.icon.transform = self.isSelected ? CGAffineTransform.init(translationX: 0, y: -40) : .identity
                self.descriptionLabel.transform = self.isSelected ? CGAffineTransform.init(translationX: 0, y: -40) : .identity
            }, completion: nil) 
        }
    }
    
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
        
        descriptionLabel = UILabel()
        self.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        [descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
         descriptionLabel.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: 20)].forEach({$0.isActive = true})
        descriptionLabel.text = "Home"
        descriptionLabel.textColor = UIColor.AppTheme.bottomBarSelectionColoe
        descriptionLabel.font = UIFont.systemFont(ofSize: 11, weight: .light)
    }
}
