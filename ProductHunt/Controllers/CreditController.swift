//
//  CreditController.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit


class CreditController: BaseController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initViews()
    }
}



extension CreditController{
    
    
    func initViews(){
        let submittedBy = UILabel()
        view.addSubview(submittedBy)
        submittedBy.numberOfLines = 100
        submittedBy.translatesAutoresizingMaskIntoConstraints = false
        [submittedBy.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
         submittedBy.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
         submittedBy.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)].forEach({$0.isActive = true})
        submittedBy.text = "Submitted by: \n S.W.A.T"
        submittedBy.textColor = .black
    }
}
