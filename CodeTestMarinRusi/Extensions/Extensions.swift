//
//  File.swift
//  CodeTestMarinRusi
//
//  Created by Marin Rusi on 2018-12-21.
//  Copyright © 2018 Marin Rusi. All rights reserved.
//

import Foundation
import UIKit



extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
    
    func updateContentViewSize() {
        var newHeight: CGFloat = 0
        for view in subviews {
            let ref = view.frame.origin.y + view.frame.height
            if ref > newHeight {
                newHeight = ref
            }
        }
        let oldSize = contentSize
        let newSize = CGSize(width: oldSize.width, height: newHeight + 100)
        contentSize = newSize
    }
}

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}

extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}
extension CGPoint{
    init(_ x:CGFloat,_ y:CGFloat) {
        self.init(x:x,y:y)
    }
}

extension NSLayoutAnchor {
    @objc func constraintEqualToAnchor(anchor: NSLayoutAnchor!, constant:CGFloat, identifier:String) -> NSLayoutConstraint! {
        let constraint = self.constraint(equalTo: anchor, constant:constant)
        constraint.identifier = identifier
        return constraint
    }
}

extension UIView {
    func constraint(withIdentifier:String) -> NSLayoutConstraint? {
        return self.constraints.filter{ $0.identifier == withIdentifier }.first
    }
}


extension UIView {
    func callRecursively(level: Int = 0, _ body: (_ subview: UIView, _ level: Int) -> Void) {
        body(self, level)
        subviews.forEach { $0.callRecursively(level: level + 1, body) }
    }
}

extension UIViewController {
    
    func reusableAlert(alertTitle: String, alertMessage: String, viewController: UIViewController) {
        let errorAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        viewController.present(errorAlert, animated: true, completion: nil)
    }
}


extension UIView {
    public func addConstraintsWithFormat(_ format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
}
