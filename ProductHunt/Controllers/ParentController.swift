//
//  ParentController.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit

class ParentController: BaseController{
    
    var guide: UILayoutGuide!
    var bottomBarContainer: BaseView!
    var bottomBar: BottomBar!
    var parentScrollView: UIScrollView!
    
    var homeController: HomeController!
    var searchController: SearchController!
    var creditController: CreditController!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initViews()
    }
}


extension ParentController: BottomBarSelectionProtocol{
    func selectedItemAt(index: Int) {
        view.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseIn,.curveEaseOut], animations: {
            self.parentScrollView.contentOffset.x = CGFloat(index) * self.view.bounds.width
        }, completion: nil)
    }
}


extension ParentController: PostSelectionProtocol{
    func selectedProtocol(with post: Post) {
        let detailController = PostDetailController()
        detailController.model = post
        self.present(detailController, animated: true, completion: nil)
    }
    
    func selectedProtocol(with id: Int) {
        self.present(PostDetailController(), animated: true, completion: nil)
    }
    
    
}



extension ParentController{
    
    func initViews(){
        
        guide = view.safeAreaLayoutGuide
        
        
        
        parentScrollView = UIScrollView.init()
        view.addSubview(parentScrollView)
        parentScrollView.translatesAutoresizingMaskIntoConstraints = false
        [parentScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         parentScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         parentScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
         parentScrollView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0)].forEach({$0.isActive = true})
        parentScrollView.isScrollEnabled = false
        
        
        homeController = HomeController.init()
        self.addChild(homeController)
        parentScrollView.addSubview(homeController.view)
        homeController.view.translatesAutoresizingMaskIntoConstraints = false
        
        homeController.view.leftAnchor.constraint(equalTo: parentScrollView.leftAnchor, constant: 0).isActive = true
        homeController.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        homeController.view.topAnchor.constraint(equalTo: parentScrollView.topAnchor, constant: 0).isActive = true
        homeController.view.bottomAnchor.constraint(equalTo: parentScrollView.bottomAnchor, constant: 0).isActive = true
        homeController.view.heightAnchor.constraint(equalTo: parentScrollView.heightAnchor).isActive = true
        homeController.selectionDelegate = self
        
        searchController = SearchController()
        self.addChild(searchController)
        parentScrollView.addSubview(searchController.view)
        searchController.view.translatesAutoresizingMaskIntoConstraints = false
        searchController.view.leftAnchor.constraint(equalTo: homeController.view.rightAnchor, constant: 0).isActive = true
        searchController.view.heightAnchor.constraint(equalTo: homeController.view.heightAnchor).isActive = true
        searchController.view.widthAnchor.constraint(equalTo: homeController.view.widthAnchor).isActive = true
        searchController.view.topAnchor.constraint(equalTo: homeController.view.topAnchor, constant: 0).isActive = true
        
        creditController = CreditController()
        self.addChild(creditController)
        parentScrollView.addSubview(creditController.view)
        creditController.view.translatesAutoresizingMaskIntoConstraints = false
        creditController.view.leftAnchor.constraint(equalTo: searchController.view.rightAnchor, constant: 0).isActive = true
        creditController.view.rightAnchor.constraint(equalTo: parentScrollView.rightAnchor, constant: 0).isActive = true
        creditController.view.topAnchor.constraint(equalTo: searchController.view.topAnchor, constant: 0).isActive = true
        creditController.view.bottomAnchor.constraint(equalTo: searchController.view.bottomAnchor, constant: 0).isActive = true
        creditController.view.widthAnchor.constraint(equalTo: searchController.view.widthAnchor).isActive = true
        
        
        bottomBarContainer = BaseView.init(with: UIColor.AppTheme.bottomBarColor, circular: false, shadow: true, borderColor: nil, borderThickness: nil)
        view.addSubview(bottomBarContainer)
        bottomBarContainer.translatesAutoresizingMaskIntoConstraints = false
        [bottomBarContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         bottomBarContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
         bottomBarContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         bottomBarContainer.heightAnchor.constraint(equalToConstant: 20 + view.safeAreaInsets.bottom + 40)].forEach({$0.isActive = true})
        
        bottomBar = BottomBar()
        view.addSubview(bottomBar)
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        [bottomBar.leftAnchor.constraint(equalTo: bottomBarContainer.leftAnchor, constant: 0),
         bottomBar.rightAnchor.constraint(equalTo: bottomBarContainer.rightAnchor, constant: 0),
         bottomBar.topAnchor.constraint(equalTo: bottomBarContainer.topAnchor, constant: 0),
         bottomBar.heightAnchor.constraint(equalToConstant: 40)].forEach({$0.isActive = true})
        bottomBar.itemSelectionDelegate = self
        
    }
}



