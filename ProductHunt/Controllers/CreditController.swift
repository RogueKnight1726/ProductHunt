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
         submittedBy.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)].forEach({$0.isActive = true})
        submittedBy.text = "Submitted by: \n Swathy"
        submittedBy.textColor = .black
        
        let subTextLabel = UILabel()
        view.addSubview(subTextLabel)
        subTextLabel.translatesAutoresizingMaskIntoConstraints = false
        [subTextLabel.leftAnchor.constraint(equalTo: submittedBy.leftAnchor, constant: 0),
         subTextLabel.topAnchor.constraint(equalTo: submittedBy.bottomAnchor, constant: 8),
         subTextLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
         subTextLabel.rightAnchor.constraint(equalTo: submittedBy.rightAnchor, constant: -16)].forEach({$0.isActive = true})
        subTextLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        subTextLabel.textColor = .black
        subTextLabel.numberOfLines = -1
        subTextLabel.text = "This is an application developed by me, Swathy, for the skill test at Haptik"
        
        
        drawBackground()
    }
    
    
    
    // This is just an added customisation to the app's layout, and also to show that I can custom draw CASHapes and is comfortable with layers and bezierpaths (if given a little more time)
    func drawBackground(){
        let waveOneLayer = CAShapeLayer()
        let waveOneLayerCurvePath = UIBezierPath.init()
        waveOneLayerCurvePath.move(to: CGPoint.init(x: 0, y: view.bounds.maxY))
        waveOneLayerCurvePath.addCurve(to: CGPoint.init(x: view.bounds.midX, y: view.bounds.midY), controlPoint1: CGPoint.init(x: view.bounds.maxX, y: view.bounds.maxY), controlPoint2: CGPoint.init(x: view.bounds.maxX, y: 3 * view.bounds.midY / 4))
        waveOneLayerCurvePath.addCurve(to: CGPoint.init(x: view.bounds.maxX, y: view.bounds.midY), controlPoint1: CGPoint.init(x: view.bounds.midX, y: view.bounds.midY), controlPoint2: CGPoint.init(x: 3 * view.bounds.maxX / 4, y: 3 * view.bounds.midY / 4))
        waveOneLayerCurvePath.addLine(to: CGPoint.init(x: view.bounds.maxX, y: view.bounds.maxY))
        waveOneLayerCurvePath.close()
        waveOneLayer.path = waveOneLayerCurvePath.cgPath
        waveOneLayer.fillColor = UIColor.AppTheme.waveOneColor.cgColor
        
        let waveTwoLayer = CAShapeLayer()
        let waveTwoCurvePath = UIBezierPath.init()
        waveTwoCurvePath.move(to: CGPoint.init(x: 0, y: view.bounds.maxY))
        waveTwoCurvePath.addCurve(to: CGPoint.init(x: view.bounds.midX, y: view.bounds.midY / 2), controlPoint1: CGPoint.init(x: 5 * view.bounds.maxX / 4, y: view.bounds.maxY), controlPoint2: CGPoint.init(x: view.bounds.maxX, y: view.bounds.minY))
        waveTwoCurvePath.addCurve(to: CGPoint.init(x: view.bounds.maxX, y: view.bounds.midY / 4), controlPoint1: CGPoint.init(x: 3 * view.bounds.midX / 2, y: view.bounds.minY - (view.bounds.maxY / 2)), controlPoint2: CGPoint.init(x: 3 * view.bounds.maxX, y: view.bounds.maxY))
        waveTwoCurvePath.addLine(to: CGPoint.init(x: view.bounds.maxX, y: view.bounds.maxY))
        waveTwoCurvePath.close()
        waveTwoLayer.path = waveTwoCurvePath.cgPath
        waveTwoLayer.fillColor = UIColor.AppTheme.waveTwoCOlor.cgColor

        
        view.layer.insertSublayer(waveOneLayer, at: 0)
        view.layer.insertSublayer(waveTwoLayer, above: waveOneLayer)
    }
}
