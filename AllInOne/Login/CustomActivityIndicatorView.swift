//
//  CustomActivityIndicatorView.swift
//  Mentr
//
//  Created by MAC7 on 07/09/18.
//  Copyright © 2018 Swapnali S. All rights reserved.
//


import UIKit
import Foundation
class CustomActivityIndicatorView: UIView {
    
    var view1: UIView!
    var activityIndicator: UIActivityIndicatorView!
    var title: String!
    var container: UIView = UIView()
    init(title1: String, center: CGPoint, width: CGFloat = 180.0, height: CGFloat = 50.0)
    {
        super.init(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        title = "Loading"
        
        let x = center.x - width/2.0
        let y = center.y - height/2.0
        
        container = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        
        view1 = UIView(frame: CGRect(x: x, y: y, width: 80, height: 80))
        view1.center = container.center
        view1.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view1.layer.cornerRadius = 10
        view1.layer.borderWidth = 1
        view1.layer.borderColor = UIColor.darkGray.cgColor
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.activityIndicator.center = CGPoint(x:self.view1.frame.size.width / 2, y:self.view1.frame.size.height / 2)
        self.activityIndicator.color = UIColor.white
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.activityIndicator.hidesWhenStopped = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        
        
        container.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        
        view1.addSubview(self.activityIndicator)
        view1.addSubview(titleLabel)
        container.addSubview(view1)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getViewActivityIndicator() -> UIView
    {
        return container
    }
    
    func startAnimating()
    {
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopAnimating()
    {
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        container.removeFromSuperview()
    }
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
