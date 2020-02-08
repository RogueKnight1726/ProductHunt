//
//  BottomBar.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit

class BottomBar: UIView{
    
    var layout: UICollectionViewFlowLayout?
    var collectionView: UICollectionView!
    let barItems: [BottomBarItems] = [.Home,.Search,.AboutMe]
    weak var itemSelectionDelegate: BottomBarSelectionProtocol?
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let _ = layout{ return }
        initViews()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}




extension BottomBar{
    
    func initViews(){
        layout = UICollectionViewFlowLayout.init()
        layout?.itemSize = CGSize.init(width: self.bounds.width / 3, height: 40)
        layout?.minimumInteritemSpacing = 0
        layout?.minimumLineSpacing = 0
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout!)
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
         collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
         collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
         collectionView.heightAnchor.constraint(equalToConstant: 40)].forEach({$0.isActive = true})
        collectionView.register(BottomBarCell.self, forCellWithReuseIdentifier: "SomeIdentifier")
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.collectionView.selectItem(at: IndexPath.init(item: 0, section: 0), animated: true, scrollPosition: .left)
        }
    }
}


extension BottomBar: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return barItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath) as! BottomBarCell
        cell.item = barItems[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelectionDelegate?.selectedItemAt(index: indexPath.row)
    }
    
}


enum BottomBarItems: String{
    case Home = "bottomHomeImage"
    case Search = "search"
    case AboutMe = "aboutMe"
}


protocol BottomBarSelectionProtocol: AnyObject{
    func selectedItemAt(index: Int)
}
