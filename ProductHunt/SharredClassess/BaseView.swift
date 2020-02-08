//
//  BaseView.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//


import UIKit

class BaseView: UIView{
    
    
    var roundedShape = CAShapeLayer()
    var curvedPath: UIBezierPath!
    var shapeColor: UIColor!
    var circular: Bool!
    var shadow: Bool!
    var shadowLayer = CAShapeLayer()
    var borderColor: CGColor?
    var borderThickness: CGFloat?
    
    convenience init(with backgroundTheme: UIColor, circular: Bool, shadow: Bool){
        self.init()
        shapeColor = backgroundTheme
        self.circular = circular
        self.shadow = shadow
    }
    
    
    convenience init(with backgroundTheme: UIColor, circular: Bool, shadow: Bool,borderColor: UIColor?,borderThickness: Int?){
        self.init()
        shapeColor = backgroundTheme
        self.circular = circular
        self.shadow = shadow
        self.borderThickness = CGFloat(borderThickness ?? 0)
        self.borderColor = borderColor?.cgColor
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
    }
    
    
    func setColorToBaseView(color: UIColor){
        shapeColor = color
        layoutSubviews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if layer.sublayers?.contains(roundedShape) ?? false{
            roundedShape.removeFromSuperlayer()
        }
        if layer.sublayers?.contains(shadowLayer) ?? false{
            shadowLayer.removeFromSuperlayer()
        }
        
        curvedPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: self.circular ? self.bounds.height / 2 : 15)
        roundedShape = CAShapeLayer()
        roundedShape.path = curvedPath.cgPath
        roundedShape.fillColor = shapeColor.cgColor
        self.layer.insertSublayer(roundedShape, at: 0)
        
        if let _ = self.borderColor, let _ = self.borderThickness{
            roundedShape.strokeColor = borderColor
            roundedShape.borderWidth = self.borderThickness!
        }
        
        
        if shadow{
            shadowLayer = CAShapeLayer()
            shadowLayer.fillColor = shapeColor.cgColor
            shadowLayer.shadowColor = UIColor.gray.cgColor
            shadowLayer.shadowRadius = 10
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
            shadowLayer.path = curvedPath.cgPath
            shadowLayer.fillColor = (backgroundColor ?? UIColor.white).cgColor
            layer.insertSublayer(shadowLayer, below: roundedShape)
        }
    }
    
    
}





